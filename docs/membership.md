# Membership

A membership is defined by a `user` and the user's `role` in a  `team`.
Once the membership is created, it means that the `user` is part of the `team`
and has a specific `role` in it.

## Entity Relationship Diagram
```mermaid
erDiagram
    role ||--o{ membership : has
    team ||--o{ membership : has
    user ||--o{ membership : has
```

## Class Diagram

```mermaid
classDiagram
    Membership --> User
    Membership --> Team
    Membership --> Role
    class User{
      +String id
      +String firstName
      +String lastName
      +String displayName
      +String avatarUrl
      +String location
    }
    class Team{ 
      +String id
      +String name
      +String teamLeadId
      +List~String~ teamMemberIds
    }
    class Role{
      +String id
      +String name
    }
    class Membership { 
      +String user_id
      +String team_id
      +String role_id
    }
```