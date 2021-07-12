//+------------------------------------------------------------------+
//|                                                 BreakEven EA.mq4 |
//|                                      Copyright 2020, ibbuhussain |
//|                                          Twitter.com/ibbuhussain |
//+------------------------------------------------------------------+
/*          DESCRIPTION
This EA is just evolved from Its original EA . The program Moves SL to the entry point of the 
selected order based on its ticket no. Condition given is the Min profit to bring SL at entry.
If the condition meets then Trade is BreakEven or else it waits till it gets there.Once the order 
is modified the EA automatically removed.
*/
#property copyright "Copyright 2020, ibbuhussain"
#property link      "Twitter.com/ibbuhussain"
#property version   "1.00"
#property strict

#include<myMade.mqh>
#include <Label.mqh>
#property  show_inputs
input datetime t ;//Time Condition to Begin EA from
input int index1 = 219363759;//Ticket No
input double profitCUt = 3 ;//Minimun Profit to bring SL to Entry
int Magicno = TimeSeconds(TimeCurrent()) + 23;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

 
int OnInit()
  {
//---
Comment(""); // Clear Comment Line on Chart
if( trading_toAllowed_Alert()){
//   Alert("###############-S T A R T--E A - BreakEven<"+_Symbol+"> (Magic_no."+Magicno+")-####################");
LabelCreate(0,"BreakEven",0,InpX,InpY,CORNER_LEFT_LOWER,"Ticket-No. "+index1,InpFont,18,
      clrAqua,InpAngle,InpAnchor,InpBack,InpSelection,InpHidden,InpZOrder); 
   LabelCreate(0,"BreakEven2",0,InpX,InpY,CORNER_LEFT_UPPER,"@ Time "+t+" Onwards","Arial",12,
      clrRosyBrown,InpAngle,InpAnchor,InpBack,InpSelection,InpHidden,InpZOrder); 
      //Comment ("Profit TRGT to bring SL to Entry "+profitCUt); 
}
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
LabelDelete(0,"BreakEven");
LabelDelete(0,"BreakEven2");

  // Alert("###############-S T O P-- A D V I S O R ( BreakEven Magic_no."+Magicno+")-####################");
LabelDelete(0,"breakeven");  
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
  
  
 if(trading_toAllowed()){
 if(TimeCurrent()> t)  { 
 if ( OrderSelect(index1,SELECT_BY_TICKET) == true){
   if (OrderProfit() > profitCUt){
   double lotss = OrderLots();
   //int orderid = OrderTicket();
 int orderid =   OrderModify(index1,0,OrderOpenPrice(),OrderTakeProfit(),0,clrNONE);
   if(orderid < 0) {Alert(GetLastError());}
     LabelCreate(0,"breakeven",0,InpX,InpY,CORNER_LEFT_UPPER,"SL Moved To BreakEven",InpFont,InpFontSize,
      clrRed,InpAngle,InpAnchor,InpBack,InpSelection,InpHidden,InpZOrder);  
      Comment("SL Moved To BreakEven");
Sleep(4500); 
LabelDelete(0,"breakeven");Comment("");

if (orderid > 0){ ExpertRemove(); }
   }//profitCUt close
   else Comment("$ "+profitCUt+" Profit not yet Reached for BreakEven");
   } 
   
 }//Trading to allowed
  }//Time condition  
}// OnTIck


 //+------------------------------------------------------------------+
/*/ UPDATE 
06AUG2020
Time Bar update to schedule the EA functioning */