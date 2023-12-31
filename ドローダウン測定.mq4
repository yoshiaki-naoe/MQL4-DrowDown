//+------------------------------------------------------------------+
//|                                                     ドローダウン測定.mq4 |
//|                                                          Rokudou |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Rokudou"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

input double maxX = 0;  //最大利益のX座標
input double maxY = 20; //最大利益のY座標
input double minX = 0;  //最大損失のX座標
input double minY = 40; //最大損失のY座標


double Maxprof = 0;
double Minprof = 0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   
//---
   return(INIT_SUCCEEDED);
  }


int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   double prof = AccountProfit();
   if(Maxprof < prof) Maxprof = prof;
   if(Minprof > prof) Minprof = prof;
   Textlabel(Maxprof,Minprof);
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }


void Textlabel(double max, double min)
{
   string maxStr = "最大利益 =" + addcomma(max,0);
   string minStr = "最大損失 =" + addcomma(min,0);

   string maxObj = "maxObj";
   string minObj = "minObj";
 
   ObjectCreate(maxObj, OBJ_LABEL, 0, 0, 0);
   ObjectCreate(minObj, OBJ_LABEL, 0, 0, 0);

   ObjectSetText(maxObj, maxStr, 14, "Meiryo UI",clrYellow);
   ObjectSetInteger(0, maxObj, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSetInteger(0, maxObj, OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
   ObjectSetInteger(0, maxObj, OBJPROP_XDISTANCE, maxX + 0);
   ObjectSetInteger(0, maxObj, OBJPROP_YDISTANCE, maxY + 0);
 
   ObjectSetText(minObj, minStr, 14, "Meiryo UI",clrYellow);
   ObjectSetInteger(0, minObj, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSetInteger(0, minObj, OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);  
   ObjectSetInteger(0, minObj, OBJPROP_XDISTANCE, minX + 0);
   ObjectSetInteger(0, minObj, OBJPROP_YDISTANCE, minY + 0);
}

string addcomma(double inputdata, int dig)
{
  string returnstr = DoubleToStr(inputdata,dig);
  int length;
  int noofcomma;
  int firstcomma;

  length = StringLen(DoubleToStr(MathFloor(inputdata),0));
  if (inputdata >= 0) noofcomma = (int)MathFloor((length - 1) / 3);
  else noofcomma = (int)MathFloor((length - 2) / 3);
  if (noofcomma == 0) return (returnstr);

  firstcomma = length - noofcomma * 3;
  if (firstcomma == 0) firstcomma = 3;

  for (int i = 0; i < noofcomma; i++){
    returnstr = StringConcatenate(StringSubstr(returnstr, 0, firstcomma + i * 4),",",StringSubstr(returnstr, firstcomma + i * 4));
  }
  
  return (returnstr);
}
