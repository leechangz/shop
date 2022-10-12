package vo;

public class Employee {
	private String employeeId;
	private String employeePass;
	private String employeeName;
	private String updateDate;
	private String createDate;
	private String active;
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeePass() {
		return employeePass;
	}
	public void setEmployeePass(String employeePass) {
		this.employeePass = employeePass;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	// 디버깅
	@Override
	public String toString() {
		return "EmployeeLogin [employeeId=" + employeeId + ", employeePass=" + employeePass + ", employeeName="
				+ employeeName + ", updateDate=" + updateDate + ", createDate=" + createDate + ", active=" + active
				+ "]";
	}
}
