export interface ChatSpinConnection {
  connection_id: string;
  status: string;
  gender: string;
  preference: string;
  paired_with?: string;
  timestamp?: number;
}
