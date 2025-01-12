CREATE TABLE Clients (
    ClientID SERIAL PRIMARY KEY,            -- Уникальный идентификатор клиента
    Name VARCHAR(100) NOT NULL,            -- Имя клиента
    Phone VARCHAR(15),                     -- Телефонный номер
    Email VARCHAR(100),                    -- Электронная почта
    Address TEXT                           -- Адрес клиента
);

-- Таблица Сотрудники
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,         -- Уникальный идентификатор сотрудника
    Name VARCHAR(100) NOT NULL,            -- Имя сотрудника
    Role VARCHAR(50),                      -- Должность
    Phone VARCHAR(15)                      -- Телефонный номер
);

-- Таблица Услуги
CREATE TABLE Services (
    ServiceID SERIAL PRIMARY KEY,          -- Уникальный идентификатор услуги
    Name VARCHAR(100) NOT NULL,            -- Название услуги
    Description TEXT,                      -- Описание услуги
    Price DECIMAL(10, 2) NOT NULL          -- Цена за единицу услуги
);

-- Таблица Заказы
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,            -- Уникальный идентификатор заказа
    ClientID INT REFERENCES Clients(ClientID) ON DELETE CASCADE, -- Клиент (FK)
    EmployeeID INT REFERENCES Employees(EmployeeID) ON DELETE SET NULL, -- Сотрудник (FK)
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время создания заказа
    Status VARCHAR(50) CHECK (Status IN ('Created', 'In Progress', 'Completed', 'Cancelled')), -- Статус заказа
    TotalPrice DECIMAL(10, 2)              -- Итоговая стоимость заказа
);

-- Таблица Детали Заказа
CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,      -- Уникальный идентификатор записи
    OrderID INT REFERENCES Orders(OrderID) ON DELETE CASCADE, -- Заказ (FK)
    ServiceID INT REFERENCES Services(ServiceID) ON DELETE CASCADE, -- Услуга (FK)
    Quantity INT NOT NULL CHECK (Quantity > 0), -- Количество единиц услуги
    SubTotal DECIMAL(10, 2) NOT NULL      -- Подытог по данной услуге
);
