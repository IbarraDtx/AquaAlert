import Map "mo:base/HashMap";
import Principal "mo:base/Principal";
import Types "Types";

module {
  public class UserManager() {
    private var users = Map.HashMap<Principal, Types.UserRole>(10, Principal.equal, Principal.hash);

    public func login(user: Principal) : Bool {
      switch (users.get(user)) {
        case null {
          users.put(user, #Normal);
          true
        };
        case (?_) { true };
      };
    };

    public func getRole(user: Principal) : ?Types.UserRole {
      users.get(user)
    };

    public func setAdmin(user: Principal) {
      users.put(user, #Admin);
    };
  };
}