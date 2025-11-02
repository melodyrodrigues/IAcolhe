import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { supabase } from "@/integrations/supabase/client";
import { CheckCircle, XCircle, Clock, TrendingUp } from "lucide-react";

interface Statistics {
  pending: number;
  approved: number;
  rejected: number;
  approvedReconstruction: number;
}

const StatisticsCard = () => {
  const [stats, setStats] = useState<Statistics>({
    pending: 0,
    approved: 0,
    rejected: 0,
    approvedReconstruction: 0,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadStatistics();
  }, []);

  const loadStatistics = async () => {
    try {
      // Get all requests
      const { data: allRequests } = await supabase
        .from("benefit_requests")
        .select("status, benefit_type");

      if (allRequests) {
        const pending = allRequests.filter(r => r.status === "pending").length;
        const approved = allRequests.filter(r => r.status === "approved").length;
        const rejected = allRequests.filter(r => r.status === "rejected").length;
        const approvedReconstruction = allRequests.filter(
          r => r.status === "approved" && r.benefit_type === "auxilio_reconstrucao"
        ).length;

        setStats({
          pending,
          approved,
          rejected,
          approvedReconstruction,
        });
      }
    } catch (error) {
      console.error("Error loading statistics:", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card className="h-full">
      <CardHeader>
        <CardTitle className="text-lg">Análise Documental IA</CardTitle>
        <p className="text-sm text-muted-foreground">
          Estatísticas de solicitações e benefícios
        </p>
      </CardHeader>
      <CardContent>
        {loading ? (
          <p className="text-sm text-muted-foreground">Carregando estatísticas...</p>
        ) : (
          <div className="space-y-4">
            {/* Status das Solicitações */}
            <div className="space-y-3">
              <div className="flex items-center justify-between p-3 bg-amber-50 rounded-lg">
                <div className="flex items-center gap-2">
                  <Clock className="w-5 h-5 text-amber-600" />
                  <span className="font-medium text-sm">Pendentes</span>
                </div>
                <Badge variant="outline" className="bg-amber-100 text-amber-700 border-amber-300">
                  {stats.pending}
                </Badge>
              </div>

              <div className="flex items-center justify-between p-3 bg-green-50 rounded-lg">
                <div className="flex items-center gap-2">
                  <CheckCircle className="w-5 h-5 text-green-600" />
                  <span className="font-medium text-sm">Aprovadas</span>
                </div>
                <Badge variant="outline" className="bg-green-100 text-green-700 border-green-300">
                  {stats.approved}
                </Badge>
              </div>

              <div className="flex items-center justify-between p-3 bg-red-50 rounded-lg">
                <div className="flex items-center gap-2">
                  <XCircle className="w-5 h-5 text-red-600" />
                  <span className="font-medium text-sm">Indeferidas</span>
                </div>
                <Badge variant="outline" className="bg-red-100 text-red-700 border-red-300">
                  {stats.rejected}
                </Badge>
              </div>
            </div>

            {/* Destaque - Aprovadas Auxílio Reconstrução */}
            <div className="mt-4 p-4 bg-gradient-primary rounded-lg text-primary-foreground">
              <div className="flex items-center gap-2 mb-2">
                <TrendingUp className="w-5 h-5" />
                <span className="font-semibold text-sm">Auxílio Reconstrução</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm opacity-90">Solicitações Aprovadas</span>
                <span className="text-2xl font-bold">{stats.approvedReconstruction}</span>
              </div>
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
};

export default StatisticsCard;
