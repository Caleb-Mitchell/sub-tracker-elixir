# Sub Tracker

Feel free to visit this work in progress at [https://sub-tracker-elixir.gigalixirapp.com](https://sub-tracker-elixir.gigalixirapp.com).

## Description

A web application used to track substitute musicians (not sandwiches) that play
various instruments, to be used as substitutes for performances when necessary.
For example, if a band normally has a trombone player and that individual is
sick and can't make it to a performance, we could select trombone from the list
of instruments to view a list of musicians that play trombone (with their
contact information). For every instrument we care to track substitute musicians
for, we have a list of musicians and their contact information. We assume that
each musician can play one instrument, for simplicity.

> Important Note: Because there are not enough musicians in the database for
> pagination to be displayed for every instrument, I wanted to point out that
> the instrument "banjo" is a great example in that case, as there are plenty of
> musicians in the database who play banjo.

## Schema (Conceptual and Physical Diagrams)

> Made with asciiflow.com

```
Conceptual
┌─────────────────┐
│                 │
│                 │
│      User       │
│                 │
│                 │
└─────────────────┘

┌─────────────────┐                    ┌────────────────┐
│                 │                 ┌──┤                │
│                 │ │ │             │  │                │
│   Instrument    ├─┼─┼───────────0─┼──┤    Musician    │
│                 │ │ │             │  │                │
│                 │                 └──┤                │
└─────────────────┘                    └────────────────┘

──────────────────────────────────────────────────────────────────────
Physical
┌───────────────────────────────┐
│ users                         │
│                               │
│ id serial PRIMARY KEY         │
│ name text NOT NULL UNIQUE     │
│ password text NOT NULL UNIQUE │
│                               │
└───────────────────────────────┘

┌───────────────────────────┐          ┌─────────────────────────────────────────────────────────────┐
│ instruments               │          │ musicians                                                   │
│                           │          │                                                             │
│ id serial PRIMARY KEY     ├─────┐    │ id serial PRIMARY KEY                                       │
│ name text NOT NULL UNIQUE │     │    │ name text UNIQUE NOT NULL                                   │
│                           │     │    │ phone_number integer                                        │
│                           │     │    │ email_address text                                          │
│                           │     └────┤ instrument_id integer FOREIGN KEY NOT NULL ON DELETE CASCADE│
└───────────────────────────┘          └─────────────────────────────────────────────────────────────┘
```

- An assumption is made here that each musician only plays one instrument in
  order to preserve a 1:Many relationship between instruments and musicians. This
  could be expanded in the future to account for musicians who would be eligible
  subs on multiple instruments.

- I chose not to validate phone numbers and email addresses specifically at the
  database level, as it is not critical to the business logic of the application
  that those values be stored consistently or even presented consistently. This
  could always be added later if necessary.
