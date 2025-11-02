-- Create enum for user roles
CREATE TYPE public.app_role AS ENUM ('user', 'agent');

-- Create user_roles table
CREATE TABLE public.user_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    role app_role NOT NULL DEFAULT 'user',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    UNIQUE(user_id, role)
);

-- Enable RLS on user_roles
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

-- Create security definer function to check roles
CREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role app_role)
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id AND role = _role
  );
$$;

-- Create benefit_requests table
CREATE TABLE public.benefit_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    user_name TEXT NOT NULL,
    chat_messages JSONB NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    agent_id UUID REFERENCES auth.users(id),
    decision_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    decision_date TIMESTAMP WITH TIME ZONE
);

-- Enable RLS on benefit_requests
ALTER TABLE public.benefit_requests ENABLE ROW LEVEL SECURITY;

-- Create document_analysis table
CREATE TABLE public.document_analysis (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    request_id UUID NOT NULL REFERENCES public.benefit_requests(id) ON DELETE CASCADE,
    document_name TEXT NOT NULL,
    analysis_result JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Enable RLS on document_analysis
ALTER TABLE public.document_analysis ENABLE ROW LEVEL SECURITY;

-- RLS Policies for user_roles
CREATE POLICY "Users can view their own roles"
    ON public.user_roles FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Agents can view all roles"
    ON public.user_roles FOR SELECT
    TO authenticated
    USING (public.has_role(auth.uid(), 'agent'));

-- RLS Policies for benefit_requests
CREATE POLICY "Users can view their own requests"
    ON public.benefit_requests FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own requests"
    ON public.benefit_requests FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Agents can view all requests"
    ON public.benefit_requests FOR SELECT
    TO authenticated
    USING (public.has_role(auth.uid(), 'agent'));

CREATE POLICY "Agents can update requests"
    ON public.benefit_requests FOR UPDATE
    TO authenticated
    USING (public.has_role(auth.uid(), 'agent'))
    WITH CHECK (public.has_role(auth.uid(), 'agent'));

-- RLS Policies for document_analysis
CREATE POLICY "Users can view their own document analysis"
    ON public.document_analysis FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.benefit_requests
            WHERE benefit_requests.id = document_analysis.request_id
            AND benefit_requests.user_id = auth.uid()
        )
    );

CREATE POLICY "Agents can view all document analysis"
    ON public.document_analysis FOR SELECT
    TO authenticated
    USING (public.has_role(auth.uid(), 'agent'));

CREATE POLICY "Users can insert their own document analysis"
    ON public.document_analysis FOR INSERT
    TO authenticated
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.benefit_requests
            WHERE benefit_requests.id = document_analysis.request_id
            AND benefit_requests.user_id = auth.uid()
        )
    );

-- Trigger to update updated_at
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_benefit_requests_updated_at
    BEFORE UPDATE ON public.benefit_requests
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();