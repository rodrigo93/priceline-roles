# Membership

A membership is defined by a `user` and the user's `role` in a  `team`.
Once the membership is created, it means that the `user` is part of the `team`
and has a specific `role` in it.

## Entity Relationship Diagram
```mermaid
erDiagram
    role ||--o{ membership : has
    team ||--|{ membership : has
    user ||--o{ membership : has
```

## Class Diagram

```mermaid
classDiagram
    Membership --> User
    Membership --> Team
    Membership --> Role
    class User{
      +String name
      +String email
    }
    class Team{
      +String name
      +List~Membership~ memberships
      +team_lead() : User
    }
    class Role{
      +String name
    }
    class Membership {
    }
```