declare @DateBegin datetime
set @DateBegin= DateBeginASP
declare @DateEnd datetime
set @DateEnd=DateEndASP
declare @FCustName varchar(80)
set @FCustName=FCustNameASP
declare @StockName varchar(80)
set @StockName=StockNameASP
declare @FFullNumber varchar(80)
set @FFullNumber=FFullNumberASP
select  S.FCheck as '审核标志',S.FBillSourceName as '单据来源', S.Fdate as '日期',S.FBillNo as '单据编号',S.FVoucherNumber as '凭证字号',
S.FFullNumber as '物料代码',
S.FItemName as '物料名称', S.FSupplyIDName as '供应商', S.FItemModel as '规格型号',convert(decimal(28,2),S.FAuxQtyMust) as '应收数量',
convert(decimal(28,2),S.Fauxqty) as '实收数量',convert(decimal(28,2),S.FStockQty) as '库存数量',
 S.FUnitIDName as '单位',convert(decimal(28,2),S.Fauxprice) as'单价',S.Famount as '金额',
S.FBatchNo as'批号',S.FExplanation as'摘要',S.FDCStockIDName as'收货仓库',S.FCustNumber as'客户代码',S.FCustName as '客户', S.FDeptIDName as '部门'
from
(select  u1.FIndex,u1.FDetailID AS FListEntryID,0  AS FSel,t15.FName AS FActualVchTplName,v1.FPlanVchTplID AS FPlanVchTplID,v1.FActualVchTplID AS FActualVchTplID,
v1.FVchInterID AS FVchInterID,v1.FTranType AS FTranType,v1.FInterID AS FInterID,u1.FEntryID AS FEntryID,t34.FNumber AS FCustNumber,CONVERT(varchar(12) , v1.Fdate, 111 ) AS Fdate,case  
when v1.FCheckerID>0 then 'Y' when v1.FCheckerID<0 then 'Y' else '' end AS FCheck,case when v1.FCancellation=1 then 'Y' else '' end AS FCancellation,
t4.FName AS FSupplyIDName,t34.FName AS FCustName,v1.FBillNo AS FBillNo,t7.FName AS FDCStockIDName,t12.FName AS FDeptIDName,t13.FNumber AS FFullNumber,
t13.Fname AS FItemName,t13.Fmodel AS FItemModel,t16.FName AS FUnitIDName,u1.FAuxQtyMust AS FAuxQtyMust,u1.Fauxqty AS Fauxqty,  (u1.Fauxqty-u1.FCommitQty) as FStockQty,u1.Fauxprice AS Fauxprice,
u1.Famount AS Famount,u1.FBatchNo AS FBatchNo,t10.FName AS FuserName,t24.FName AS FCheckerName,u1.FNote AS FNote,
(SELECT (SELECT FName FROM t_VoucherGroup WHERE FGroupID=t_Voucher.FGroupID)+'-'+CONVERT(Varchar(30),FNumber)   
FROM  t_Voucher  WHERE  FVoucherid=v1.FVchInterID)  AS FVoucherNumber,v1.FExplanation AS FExplanation,t106.FName AS FEmpIDName,t107.FName AS FManagerIDName,
t13.FQtyDecimal AS FQtyDecimal,t13.FPriceDecimal AS FPriceDecimal,t30.FName AS FBaseUnitID,Case WHEN t13.FStoreUnitID=0 THEN '' Else  t500.FName end AS FCUUnitName,
Case When v1.FCurrencyID is Null Or v1.FCurrencyID='' then (Select FScale From t_Currency Where FCurrencyID=1) else t503.FScale end   AS FAmountDecimal,
case when (v1.FROB <> 1) then 'Y' else '' end AS FRedFlag,t523.FBillNo AS FZPBillNo,
CASE WHEN v1.FTranStatus=1 THEN 'Y' ELSE '' END AS FTranStatus,t554.FName AS FSecUnitName,u1.FSecCoefficient AS FSecCoefficient,u1.FSecQty AS FSecQty,
IsNull(t561.FPrintCount,0) AS FPrintCount,case when v1.FCancellation=1 then '已作废' when v1.FStatus = 0 then '未审核' when v1.FStatus>0 then '已审核' else '' end AS FBillStatus,
u1.FUnitID AS FUnitID,t16.FCoefficient AS FCoefficient,t13.FUnitGroupID AS FUnitGroupID,t2555.FName AS FBillSourceName,v1.FChildren AS FChildren,
v1.FStatus AS FStatus from ICStockBill v1 INNER JOIN ICStockBillEntry u1 ON     v1.FInterID = u1.FInterID   AND u1.FInterID <>0 
 LEFT OUTER JOIN t_Supplier t4 ON     v1.FSupplyID = t4.FItemID   AND t4.FItemID <>0 
 LEFT OUTER JOIN t_Organization t34 ON     v1.FCustID = t34.FItemID   AND t34.FItemID <>0 
 INNER JOIN t_Stock t7 ON     u1.FDCStockID = t7.FItemID   AND t7.FItemID <>0 
 LEFT OUTER JOIN t_Emp t8 ON     v1.FFManagerID = t8.FItemID   AND t8.FItemID <>0 
 INNER JOIN t_User t10 ON     v1.FBillerID = t10.FUserID   AND t10.FUserID <>0 
 LEFT OUTER JOIN t_Department t12 ON     v1.FDeptID = t12.FItemID   AND t12.FItemID <>0 
 INNER JOIN t_ICItem t13 ON     u1.FItemID = t13.FItemID   AND t13.FItemID <>0 
 INNER JOIN t_MeasureUnit t16 ON     u1.FUnitID = t16.FItemID   AND t16.FItemID <>0 
 LEFT OUTER JOIN t_User t24 ON     v1.Fcheckerid = t24.FUserID   AND t24.FUserID <>0 
 LEFT OUTER JOIN t_MeasureUnit t30 ON     t13.FUnitID = t30.FMeasureUnitID   AND t30.FMeasureUnitID <>0 
 LEFT OUTER JOIN ICVoucherTpl t15 ON     v1.FActualVchTplID = t15.FInterID   AND t15.FInterID <>0 
 LEFT OUTER JOIN t_Emp t106 ON     v1.FEmpID = t106.FItemID   AND t106.FItemID <>0 
 LEFT OUTER JOIN t_Emp t107 ON     v1.FManagerID = t107.FItemID   AND t107.FItemID <>0 
 LEFT OUTER JOIN t_MeasureUnit t500 ON     t13.FStoreUnitID = t500.FItemID   AND t500.FItemID <>0 
 LEFT OUTER JOIN t_Currency t503 ON     v1.FCurrencyID = t503.FCurrencyID   AND t503.FCurrencyID <>0 
 LEFT OUTER JOIN ZPStockBill t523 ON     v1.FZPBillInterID = t523.FInterID   AND t523.FInterID <>0 
 LEFT OUTER JOIN t_MeasureUnit t554 ON     t13.FSecUnitID = t554.FItemID   AND t554.FItemID <>0 
 LEFT OUTER JOIN ICPrintCount t561 ON   v1.FInterID = t561.FInterID  AND t561.FInterID<>0   And t561.FID=v1.FTranType
 LEFT OUTER JOIN ICChange t570 ON   u1.FSourceInterID = t570.FID  AND t570.FID<>0 
 LEFT OUTER JOIN t_SubMessage t2555 ON     v1.FBillSource = t2555.FInterID   AND t2555.FInterID <>0   And t2555.FTypeID=255 
 where 1=1 AND  (v1.FTranType=10 AND (v1.FCancellation = 0))  ) S 
 where S.Fdate >=(case when @DateBegin!='' then @DateBegin else S.Fdate end) and S.Fdate <=(case when @DateEnd!='' then @DateEnd else S.Fdate end)
 and S.FCustName=(case when @FCustName!='' then @FCustName else S.FCustName end)
 and S.FDCStockIDName=(case when @StockName!='' then @StockName else S.FDCStockIDName end)
 and S.FFullNumber=(case when @FFullNumber!='' then @FFullNumber else S.FFullNumber end)
 order by S.FInterID,S.FIndex