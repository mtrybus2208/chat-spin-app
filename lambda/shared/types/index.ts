export interface ChatSpinConnection {
  connection_id: string;
  status: string;
  gender: string;
  preference: string;
  paired_with?: string;
  timestamp?: number;
}

export enum EventAction {
  CONNECTED = "connected",
  DISCONNECTED = "disconnected",
  SEND_MESSAGE = "sendMessage",
  USER_MATCH = "userMatch",
}
export interface SocketMessage {
  action: EventAction;
  data: unknown;
}
