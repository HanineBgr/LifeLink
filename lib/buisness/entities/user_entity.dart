


class UserEntity {
 final String id;
   final String email;
    final String firstName;
    final String lastName;
    final String pic;
    final String role;
    final String? gender;
   
  
     final String? dateOfBirth;
   final List<dynamic>? providers;

 final String UID;
  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.pic,
    required this.role,
     this.gender,
    
           
       this.dateOfBirth,
       this.providers,
       
          required this.UID,
  });
}
