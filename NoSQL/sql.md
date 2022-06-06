~~~sql
```sql
select @pageTag(){
*
@}
from (select FUND_CODE,
    FUND_NAME,
    FUND_NAME_ABBR,
    unit_nav,
    DID,
    TA_TYPE,
    TA_CODE,
    fund_type,
    share_class,
    fund_income,
    annualized_one_week,
    fund_type_name,
    TA_NAME,
    day_change,
    week_change,
    month_change,
    month3_change,
    month6_change,
    year_on_change,
    year_change,
    year2_change,
    year3_change,
    total_size,
    START_DATE,
    nav_date,
    existing_years,
    fund_type_two,
    remark1,
    remark2,
    remark3,
    e_mon_over_date,
    trustee_name,
    fundManagerCode,
    minAccountBalance,
    minPurchase,
    MAX_PURCHASE,
    fundStatus,
    minBidsAmountByInst,
    TRAS_TYPE,
    fundManager,
    fundManagerName,
    DISCOUNT, DISCOUNT_FIXED,COMPENSATION_DISCOUNT,total_size_cla,
    ROWNUM rn
    from (SELECT fb.fund_code,
    fb.fund_name,
    fb.fund_name_abbr,
    TO_CHAR(fb.UNIT_NAV, 'FM990.9990') unit_nav,
    fb.did,
    fb.ta_type,
    fb.ta_code,
    fb.CATEGORY1 fund_type,
    decode(fb.share_class, '0', '前端收费', '后端收费') share_class,
    decode(fb.fund_income, '', '-', '0', '-',
    TO_CHAR(fb.fund_income, 'FM990.9990')) fund_income,
    decode(fb.annualized_one_week, '', '-', '0', '-',
    TO_CHAR(fb.annualized_one_week * 100, 'FM990.9990')) annualized_one_week,
    fb.CATEGORY1_NAME fund_type_name,
    fb.ta_name,
    decode(fb.day_change, '', '-',
    TO_CHAR(fb.day_change * 100, 'FM99990.90')) day_change,
    decode(fb.week_change, '', '-',
    TO_CHAR(fb.week_change * 100, 'FM99990.90')) week_change,
    decode(fb.month_change, '', '-',
    TO_CHAR(fb.month_change * 100, 'FM99990.90')) month_change,
    decode(fb.month3_change, '', '-',
    TO_CHAR(fb.month3_change * 100, 'FM99990.90')) month3_change,
    decode(fb.month6_change, '', '-',
    TO_CHAR(fb.month6_change * 100, 'FM99990.90')) month6_change,
    decode(fb.year_on_change, '', '-', TO_CHAR(fb.year_on_change * 100, 'FM99990.90'))
    year_on_change,
    decode(fb.year_change, '', '-', TO_CHAR(fb.year_change * 100, 'FM99990.90'))
    year_change,
    decode(fb.year2_change, '', '-', TO_CHAR(fb.year2_change * 100, 'FM99990.90'))
    year2_change,
    decode(fb.year3_change, '', '-', TO_CHAR(fb.year3_change * 100, 'FM99990.90'))
    year3_change,
    TO_CHAR(round(fb.total_size / 100000000, 2), 'FM999999990.90') total_size,
    decode(fb.start_date,'19000101','-',fb.start_date) start_date,
    to_char(to_date(fb.nav_date, 'yyyymmdd'), 'yyyy-mm-dd') nav_date,
    decode(fb.start_date,'19000101', '-', TO_CHAR(fb.existing_years, 'FM9990.0')) existing_years,
    fb.CATEGORY2_NAME fund_type_two,
    decode(fb.remark1, '', '-', fb.REMARK1) remark1,
    decode(fr.REDEMPTION_PAY_PERIOD, null, '-', concat('T+', fr.REDEMPTION_PAY_PERIOD)) remark2,
    decode(fb.remark3, '', '-', fb.REMARK3) remark3,
    decode(fb.e_mon_over_date, '', '-', fb.E_MON_OVER_DATE) e_mon_over_date,
    decode(fb.trustee_name, '', '-', fb.TRUSTEE_NAME) trustee_name,
    fd2.did fundManagerCode,
    (select distributor_Name from info_distributor where did = fb.did) fundManagerName,
    TO_CHAR(fd2.min_Account_Balance, 'FM999,999,999,999,990.90') minAccountBalance,
    TO_CHAR(fd2.min_Purchase, 'FM999,999,999,999,990.90') minPurchase,
    decode(fd2.fund_Status, '0', '正常申赎', '1', '发行募集', '4', '暂停交易', '5', '暂停申购', '6', '暂停赎回', '8',
    '基金终止', '9',
    '基金封闭') fundStatus,
    TO_CHAR(fd2.min_bids_amount_by_inst, 'FM999,999,999,999,990.90') minBidsAmountByInst,
    decode(fb.TRAS_TYPE, '', '-', '01', '按日结转', '02', '按月结转', '03', '按季结转', '09',
    '-') TRAS_TYPE,
    fb.manager fundManager,
    case
    when fd2.MAX_PURCHASE >= 999999999999 or fd2.MAX_PURCHASE = 0 then '无限额'
    else TO_CHAR(trunc(fd2.MAX_PURCHASE / 10000, 2), 'FM999,999,999,999,990.90') end MAX_PURCHASE,
    fb.DISCOUNT, fb.DISCOUNT_FIXED,fb.COMPENSATION_DISCOUNT,decode(fb.total_size_cla,'','-',TO_CHAR(round(fb.total_size_cla / 100000000, 2), 'FM999999990.90')) total_size_cla
    FROM FUND_BASE fb
    join fund_distributor fd2 on fb.fund_code = fd2.fund_code and fd2.distributor_Type = '1'
    left join (select FUND_CODE, max (REDEMPTION_PAY_PERIOD) REDEMPTION_PAY_PERIOD from FUND_RELATION where SHARE_CLASS = '0' group by FUND_CODE) fr on fb.FUND_CODE=fr.FUND_CODE
    where not exists (select bl.FUND_CODE from TRADE_BLACK_LIST bl where bl.FUND_CODE = fb.FUND_CODE and ORG_ID = (select r.ORG_ID from SYS_OPERATOR r where r.OP_ID = #opId#))
    @if(!isBlank(totalSize)){
    and round(fb.total_size / 100000000, 2) between #totalSizes[0]# and #totalSizes[1]#
    @}
    @if(!isBlank(existingYears)){
    and fb.existing_years between #years[0]# and #years[1]#
    @}
    @if(isNotEmpty(fundTypes)){
    @if(isNotEmpty(fundTypeTwo)){
    and (
    @for(var i=0;i<fundTypes.~ size;i++){
    @if(i>0){
    or
    @}
    @if(isEmpty(fundTypeTwo)){
    (fb.CATEGORY1 = #fundTypes[i]#)
    @} else {
    (fb.CATEGORY1 = #fundTypes[i]# AND fb.CATEGORY2_NAME IN (
    @for(id in fundTypeTwos[i]){
    #id# #text(idLP.last?"":"," )#
    @}
    ))
    @}
    @}
    )
    @} else {
    and fb.CATEGORY1 IN (
    @for(id in fundTypes){
    #id# #text(idLP.last?"":"," )#
    @}
    )
    @}
    @}
    @if(isNotEmpty(copyTradeStatus)){
    and fd2.FUND_STATUS in (
    @for(id in copyTradeStatus){
    #id# #text(idLP.last?"":"," )#
    @}
    )
    @}
    @if(!isBlank(filterFundName)){
    @if(isBlank(fundType)){
    and not exists (select *
    from FUND_BASE b
    where b.FUND_CODE = fb.FUND_CODE
    and b.CATEGORY1 = '05')
    and b.FUND_NAME_ABBR like #'%'+filterFundName+'%'#)
    @} else {
    @if(strutil.contain(fundType, '05')){
    and not exists (select *
    from FUND_BASE b
    where b.FUND_CODE = fb.FUND_CODE
    and b.CATEGORY1 = '05'
    and b.FUND_NAME_ABBR like #'%'+filterFundName+'%'#)
    @}
    @}
    @}
    @if(!isBlank(fundManagerCode)){
    and fb.did IN (
    @for(id in dids){
    #id# #text(idLP.last?"":"," )#
    @}
    )
    @}
    @if(!isBlank(maxPurchase)){
    and (fd2.max_purchase/10000) >= #maxPurchase#
    @}
    @if(!isBlank(fund)){
    and (fb.FUND_CODE like #'%'+fund+'%'# or fb.FUND_NAME like #'%'+fund+'%'# or fb.FUND_NAME_ABBR like #'%'+fund+'%'#)
    @}
    @if(!isBlank(fundMngWhiteListFlag)){
    and fb.did in (select a.FUND_MANAGER_CODE from FUND_MANAGER_LIST a, SYS_OPERATOR b where a.ORG_ID=b.ORG_ID and b.OP_ID = #opId#)
    @}
    @if(!isBlank(orderBy)){
        @if(orderBy == 'dayChange'){
            ORDER BY to_number(fb.DAY_CHANGE) 
            @if(desc == 0){
                DESC 
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'weekChange'){
            ORDER BY to_number(fb.WEEK_CHANGE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'monthChange'){
            ORDER BY to_number(fb.MONTH_CHANGE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'month3Change'){
            ORDER BY to_number(fb.MONTH3_CHANGE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'month6Change'){
            ORDER BY to_number(fb.MONTH6_CHANGE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'yearOnchange'){
            ORDER BY to_number(fb.YEAR_ON_CHANGE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'yearChange'){
            ORDER BY to_number(fb.YEAR_CHANGE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'year2Change'){
            ORDER BY to_number(fb.YEAR2_CHANGE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'year3Change'){
            ORDER BY to_number(fb.YEAR3_CHANGE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'annualizedOneWeek'){
            ORDER BY to_number(fb.ANNUALIZED_ONE_WEEK)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'fundIncome'){
            ORDER BY to_number(fb.FUND_INCOME)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'totalSize'){
            ORDER BY to_number(fb.TOTAL_SIZE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'startDate'){
            ORDER BY to_number(fb.START_DATE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'existingYears'){
            ORDER BY to_number(fb.EXISTING_YEARS)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'totalSizeCla'){
            ORDER BY to_number(fb.TOTAL_SIZE_CLA)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'unitNav'){
            ORDER BY to_number(fb.UNIT_NAV)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'navDate'){
            ORDER BY to_number(fb.NAV_DATE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'maxPurchase'){
            ORDER BY to_number(fd2.MAX_PURCHASE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'minAccountBalance'){
            ORDER BY to_number(fd2.MIN_ACCOUNT_BALANCE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'minPurchase'){
            ORDER BY to_number(fd2.MIN_PURCHASE)
            @if(desc == 0){
                DESC
            @}
            NULLS LAST, fb.fund_code) a) b
        @}else if(orderBy == 'minBidsAmountByInst'){
            ORDER BY to_number(fd2.MIN_BIDS_AMOUNT_BY_INST)
            @if(desc == 0){
                DESC 
            @}
            NULLS LAST, fb.fund_code) a) b
        @}
    @}else {
        ORDER BY fb.fund_code ) a) b
    @}
```
~~~