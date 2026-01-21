trigger SetUsageTypeOnApplicationForm on ApplicationForm (before insert, before update) {
    for (ApplicationForm appForm : Trigger.new) {
        appForm.UsageType = 'EmployeeRecruitment';
    }
}