module {
  public type UserRole = {#Normal; #Admin};
  
  public type Location = {
    latitude: Float;
    longitude: Float;
  };

  public type Report = {
    id: Nat;
    description: Text;
    status: Text;
    user: Principal;
    timestamp: Int;
    location: ?Location;
  };
}