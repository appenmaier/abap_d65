@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Query'
@Metadata.ignorePropagatedAnnotations: false
define view entity Z00_C_EmployeeQuery
  with parameters
    P_TargetCurrencyCode : /dmo/currency_code,
    @EndUserText.label: 'Date of Evaluation'
    @EndUserText.quickInfo: 'Date of Evaluation'
    @Environment.systemField: #SYSTEM_DATE
    P_DateOfEvaluation   : abap.dats
  as select from Z00_R_Employee
{
  key EmployeeId,
      FirstName,
      LastName,
      DepartmentId,
      _Department.Description                                                                 as DepartmentDescription,

      /* Transient Data */
      @EndUserText.label: 'Assistant Name'
      @EndUserText.quickInfo: 'Assistant Name'
      concat_with_space(_Department._Assistant.FirstName, _Department._Assistant.LastName, 1) as AssistantName,

      @EndUserText.label: 'Employee Role'
      @EndUserText.quickInfo: 'Employee Role'
      case when EmployeeId = _Department.HeadId then 'H'
           when EmployeeId = _Department.AssistantId then 'A'
           else ''
      end                                                                                     as EmployeeRole,
      @EndUserText.label: 'Monthly Salary'
      @EndUserText.quickInfo: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast($projection.AnnualSalaryConverted as abap.fltp) / 12.0                             as MonthlySalaryConverted,

      $parameters.P_TargetCurrencyCode                                                        as CurrencyCode,
      @EndUserText.label: 'Company Affiliation'
      @EndUserText.quickInfo: 'Company Affiliation'
      division(dats_days_between(EntryDate, $parameters.P_DateOfEvaluation), 365, 1)          as CompanyAffiliation,

      @EndUserText.label: 'Annual Salary'
      @EndUserText.quickInfo: 'Annual Salary'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(
        amount => AnnualSalary,
        source_currency => CurrencyCode,
        target_currency => $parameters.P_TargetCurrencyCode,
        exchange_rate_date => $parameters.P_DateOfEvaluation,
        error_handling => 'SET_TO_NULL' )                                                     as AnnualSalaryConverted,

      /* Associations */
      _Department
}
