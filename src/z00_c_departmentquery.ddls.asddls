@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department Query'
define view entity Z00_C_DepartmentQuery
  with parameters
    P_TargetCurrencyCode : /dmo/currency_code,
    @Environment.systemField: #SYSTEM_DATE
    P_DateOfEvaluation   : abap.dats
  as select from     Z00_C_EmployeeQuery( P_TargetCurrencyCode: $parameters.P_TargetCurrencyCode, P_DateOfEvaluation: $parameters.P_DateOfEvaluation ) as e
    right outer join Z00_R_Department                                                                                                                  as d on d.Id = e.DepartmentId
{
  key e.DepartmentId,
      d.Description,
      avg(e.CompanyAffiliation as abap.dec(16,2)) as AverageAffiliation,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      sum(e.AnnualSalaryConverted)                as TotalSalary,
      e.CurrencyCode
}
group by
  e.DepartmentId,
  d.Description,
  e.CurrencyCode
