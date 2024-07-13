import Principal "mo:base/Principal";
import Types "Types";
import UserManagement "UserManagement";
import ReportManagement "ReportManagement";
import Error "mo:base/Error";

actor AquaAlert {
  let userManager = UserManagement.UserManager();
  let reportManager = ReportManagement.ReportManager();

  public shared(msg) func login() : async Bool {
    userManager.login(msg.caller)
  };

  public shared(msg) func getRole() : async ?Types.UserRole {
    userManager.getRole(msg.caller)
  };

  public shared(msg) func addReport(description: Text, location: ?Types.Location) : async Nat {
    switch (userManager.getRole(msg.caller)) {
      case null { throw Error.reject("User not logged in") };
      case (?_) {
        reportManager.addReport(description, location, msg.caller)
      };
    };
  };

  public shared(msg) func updateStatus(reportId: Nat, newStatus: Text) : async () {
    switch (userManager.getRole(msg.caller)) {
      case (?#Admin) {
        reportManager.updateStatus(reportId, newStatus);
      };
      case (_) {
        throw Error.reject("Not authorized");
      };
    };
  };

  public query func getReports() : async [Types.Report] {
    reportManager.getReports()
  };

  // Función para establecer un administrador (esto debería estar protegido)
  public shared(msg) func setAdmin(user: Principal) : async () {
    assert(msg.caller == Principal.fromText("REPLACE_WITH_OWNER_PRINCIPAL_ID"));
    userManager.setAdmin(user);
  };
}