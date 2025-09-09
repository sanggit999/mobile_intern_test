# LocationIQ

> This application is built to **test map features** and functionalities related to locations

## Features

- 🏗️ Clean Architecture


## Demo
![Image](https://github.com/user-attachments/assets/b1544008-ae77-4483-90d2-0923172adf00)


## Folder Structure

```bash
lib/
├── core/                     # Common components shared across the project
│   ├── error/                # Global error handling
│   ├── helper/mapper/        # Convert between Model ↔ Entity
│   ├── network/              # API Client (Dio, Http, ...)
│   └── usecase/              # Base UseCase
│
├── data/location/            # Data layer
│   ├── data_sources/         # Data sources (API, external services)
│   ├── models/               # Data Models (raw data from API)
│   └── repositories_impl/    # Repository implementation (map Model → Entity)
│
├── domain/location/          # Domain layer
│   ├── entities/             # Entities (business objects)
│   ├── repositories/         # Abstract Repository (contract)
│   └── usecases/             # Business UseCases
│
├── presentation/             # UI layer
│   ├── cubit/                # State management (Cubit + State)
│   └── home_page.dart        # UI screen
│
├── di.dart                   # Dependency Injection
├── main.dart                 # App entry point

```

## Quick Start

1. **Clone and install**
   ```bash
   git clone https://github.com/sanggit999/mobile_intern_test
   cd mobile_intern_test
   flutter pub get
   ```

2. **Run**
   ```bash
   flutter run
   ```


## License

❤️ Created by [SangDeveloper999]
