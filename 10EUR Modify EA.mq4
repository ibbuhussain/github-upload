//+------------------------------------------------------------------------------------------+
//|                              10EUR Modify EA 02_April Update.mq4 |
//|                                      Copyright 2021, ibbuhussain |
//|                                          Twitter.com/ibbuhussain |
//+------------------------------------------------------------------------------------------+
#property copyright "Copyright 2021, ibbuhussain"
#property link      "Twitter.com/ibbuhussain"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
#include <myMade.mqh>
#property show_inputs
//+------------------------------------------------------------------+
int Magicno = Seconds();
input int orderID = 0; //Pending Order Checking
input int orderID1= 0; //Modify the order #1
input int orderID2= 0; //Modify the order #2

input string lbl= "10EA Modify TP ea"; //Label

//+------------------------------------------------------------------+
input double TP = 0;//Modify New Tp order #1
double SL = 0;//Modify New Sl order #1

input double TP2 = 0;//Modify New Tp order #2
double SL2 = 0;//Modify New Sl order #2

//+------------------------------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------------------------------+
int OnInit()
  {
//---
   Comment("EA Placed On Chart @ "+ TimeCurrent());
   LabelCreate(0,"10EUR EA",0,InpX,InpY,CORNER_LEFT_UPPER,lbl,"Arial",19,
               clrAquamarine,InpAngle,InpAnchor,InpBack,InpSelection,InpHidden,InpZOrder);

   LabelCreate(0,"10EUR EA1",0,InpX,InpY,CORNER_RIGHT_UPPER,orderID+" _New Order/Pending","Arial",9,
               clrAntiqueWhite,InpAngle,InpAnchor,InpBack,InpSelection,InpHidden,InpZOrder);
   LabelCreate(0,"10EUR EA2",0,InpX,InpY,CORNER_LEFT_LOWER,orderID1+" _1st To be changed","Arial",9,
               clrAntiqueWhite,InpAngle,InpAnchor,InpBack,InpSelection,InpHidden,InpZOrder);
   LabelCreate(0,"10EUR EA3",0,InpX,InpY,CORNER_RIGHT_LOWER,orderID2+" _2nd To be changed","Arial",9,
               clrAntiqueWhite,InpAngle,InpAnchor,InpBack,InpSelection,InpHidden,InpZOrder);

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   Comment(""+ TimeCurrent());//
   LabelCreate(0,"10EUR EA3",0,InpX,InpY,CORNER_RIGHT_LOWER,
               "Prev. order Modified as you Desired / EA REMOVED @ "+TimeCurrent(),"Arial",12,
               clrYellow,InpAngle,InpAnchor,InpBack,InpSelection,InpHidden,InpZOrder);
   LabelDelete(0,"10EUR EA");
   LabelDelete(0,"10EUR EA1");
   LabelDelete(0,"10EUR EA2");
   LabelDelete(0,"10EUR EA3");

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   if(!totalOrderbyMagicNo(Magicno))
     {
      int ot;
      if(OrderSelect(orderID,SELECT_BY_TICKET)==true)
        {
         ot = OrderType();
        }

      if(ot==0 || ot==1)
        {
         Comment("Order is Active");

         int Order =  OrderModify(orderID1,OrderOpenPrice(),SL,TP,0,clrNONE);
         int Order2 =  OrderModify(orderID2,OrderOpenPrice(),SL2,TP2,0,clrNONE);

         if(Order > 0 || Order2 > 0)
           {
            Comment("Order is Modified as you Said");
            SendNotification("Order is Modified -10EUR Modify EA");
            ExpertRemove();
           }
         else
           {
            Comment("OrderModify ERROR");
           }
        }
      else
         Comment("Order is Still Pending");


     }//Magic No Close



   int ct;
   if(OrderSelect(orderID1,SELECT_BY_TICKET)==true)
     {
      ct = OrderCloseTime();
     }
   if(ct>0)
     {
      OrderDelete(orderID); // Deletes Pending Order.
      OrderDelete(orderID2); // Deletes SECOND Pending Order.
      Sleep(666);
      ExpertRemove();
     }




  }//Ontick Close
//+------------------------------------------------------------------+
