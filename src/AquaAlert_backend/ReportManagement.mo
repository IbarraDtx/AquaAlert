import Array "mo:base/Array";
import Types "Types";
import Time "mo:base/Time";
import Principal "mo:base/Principal";

module {
  public class ReportManager() {
    private var reports : [Types.Report] = [];

    public func addReport(description: Text, location: ?Types.Location, user: Principal) : Nat {
      let newReport : Types.Report = {
        id = reports.size();
        description = description;
        location = location;
        status = "Pending";
        user = user;
        timestamp = Time.now();
      };
      reports := Array.append(reports, [newReport]);
      reports.size() - 1
    };

    // El resto de las funciones permanecen igual...

    public func updateStatus(reportId: Nat, newStatus: Text) {
      reports := Array.map(reports, func (report: Types.Report): Types.Report {
        if (report.id == reportId) {
          {report with status = newStatus}
        } else report
      });
    };

    public func getReports() : [Types.Report] {
      reports
    };

    public func toStable() : [Types.Report] {
      reports
    };

    public func fromStable(stableReports: [Types.Report]) {
      reports := stableReports;
    };
  };
}