# Ruby Architecture Journey: Legacy to Clean Code 💎

**Status:** 🚧 In Progress (Refactoring Stage)

## 🎯 Project Goal

This repository documents my journey mastering **Advanced Ruby Architecture**.
The goal isn't just to build a Betting System, but to take a deliberately **poorly designed codebase** (Legacy Simulation) and transform it into a robust, scalable system using industry-best practices.

## 🧠 Key Concepts Applied

I am applying the following concepts strictly:

- **SOLID Principles** (SRP, OCP, LSP, ISP, DIP)
- **Object Calisthenics** (Exercise in discipline and encapsulation)
- **Refactoring Patterns** (Martin Fowler)
- **Clean Architecture** (Decoupling Domain from Frameworks)
- **TDD** (Test Driven Development with RSpec)

## 📚 The Roadmap

### Phase 1: Analysis & Diagnosis 🕵️‍♂️

- [x] Setup Dockerized Environment.
- [x] Analyze the "Legacy" Code (God Objects, Primitive Obsession).
- [x] Identify violations of "Tell, Don't Ask".

### Phase 2: Refactoring & Hardening 🛠️

- [x] Extract **Domain Objects** (User, Match) from global Hashes.
- [ ] Implement **Service Objects** for external interactions.
- [ ] Remove nested conditionals using **Polymorphism**.
- [ ] Apply **Value Objects** for Money and Odds.

### Phase 3: Architectural Evolution 🏛️

- [ ] Decouple Persistence from Domain Logic.
- [ ] Implement Use Case interactions.

## 🚀 How to Run

This project runs in a Docker container to ensure environment consistency.

1. **Clone the repo:**

   ```bash
   git clone https://github.com/jeanflaragao/ruby_refactoring
   cd ruby_refactoring

   ```

2. **Start the environment:**

   ```bash
   docker compose up -d

   ```

3. **Run the code:**
   ```bash
   docker-compose exec app ruby betting.rb
   ```
