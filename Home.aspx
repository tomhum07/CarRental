<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="CarRental.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        /* ===== HOME PAGE ===== */

        .home-hero {
            background: #333;
            color: white;
            padding: 100px 20px;
            text-align: center;
        }

        .hero-content {
            max-width: 800px;
            margin: 0 auto;
        }

            .hero-content h1 {
                font-size: 42px;
                margin-bottom: 20px;
            }

            .hero-content p {
                font-size: 18px;
                color: #d1d5db;
                margin-bottom: 30px;
            }

        .btn-primary {
            background: #2563eb;
            color: white;
            padding: 14px 30px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 16px;
            transition: background 0.3s;
        }

            .btn-primary:hover {
                background: #1d4ed8;
            }

        /* FEATURES */
        .home-features {
            max-width: 1200px;
            margin: 60px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 30px;
        }

        .feature {
            background: white;
            padding: 30px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        }

            .feature i {
                font-size: 36px;
                color: #2563eb;
                margin-bottom: 15px;
            }

            .feature h3 {
                margin-bottom: 10px;
                font-size: 20px;
            }

            .feature p {
                color: #6b7280;
                font-size: 15px;
            }
        /* ===== POPULAR VEHICLES ===== */

        .home-vehicles {
            background: #f9fafb;
            padding: 70px 20px;
            text-align: center;
        }

            .home-vehicles h2 {
                font-size: 32px;
                margin-bottom: 40px;
            }

        .vehicle-list {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 30px;
        }

        .vehicle-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        }

            .vehicle-card img {
                width: 100%;
                min-height: 60%;
                border-radius: 12px;
                margin-bottom: 15px;
            }
            .vehicle-card h4 {
                font-size: 18px;
                margin-bottom: 10px;
            }

            .vehicle-card p {
                color: #6b7280;
                margin-bottom: 15px;
            }

        .btn-outline {
            display: inline-block;
            padding: 10px 24px;
            border-radius: 10px;
            border: 1px solid #2563eb;
            color: #2563eb;
            text-decoration: none;
            transition: all 0.3s;
        }

            .btn-outline:hover {
                background: #2563eb;
                color: white;
            }

        /* ===== PROCESS ===== */

        .home-process {
            padding: 70px 20px;
            text-align: center;
        }

            .home-process h2 {
                font-size: 32px;
                margin-bottom: 40px;
            }

        .process-list {
            max-width: 1000px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
        }

        .process-step {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        }

            .process-step span {
                display: inline-block;
                width: 44px;
                height: 44px;
                line-height: 44px;
                border-radius: 50%;
                background: #2563eb;
                color: white;
                font-weight: bold;
                margin-bottom: 15px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <!-- HERO -->
    <section class="home-hero">
        <div class="hero-content">
            <h1>Thuê xe dễ dàng – Giá minh bạch</h1>
            <p>Đặt xe nhanh, không phí ẩn, hỗ trợ tận tâm 24/7</p>
            <a href="VehicleList.aspx" class="btn-primary">Xem xe ngay</a>
        </div>
    </section>

    <!-- FEATURES -->
    <section class="home-features">
        <div class="feature">
            <i class="fa-solid fa-car"></i>
            <h3>Đa dạng dòng xe</h3>
            <p>Sedan, SUV, bán tải, xe gia đình và xe du lịch</p>
        </div>

        <div class="feature">
            <i class="fa-solid fa-file-signature"></i>
            <h3>Thủ tục nhanh</h3>
            <p>Chỉ cần CCCD & bằng lái, nhận xe trong 10 phút</p>
        </div>

        <div class="feature">
            <i class="fa-solid fa-shield-halved"></i>
            <h3>An tâm tuyệt đối</h3>
            <p>Bảo hiểm đầy đủ, xe kiểm tra định kỳ</p>
        </div>
    </section>

    <!-- POPULAR VEHICLES -->
    <section class="home-vehicles">
        <h2>Xe được thuê nhiều</h2>

        <div class="vehicle-list">
            <div class="vehicle-card">
                <div class="img-container">
                    <img src="/Image/Vehicle/FordRanger.jpg" alt="Ford Ranger" />
                </div>
                <h4>Ford Ranger</h4>
                <p>Giá từ <strong>900.000đ/ngày</strong></p>
                <a href="VehicleList.aspx" class="btn-outline">Thuê ngay</a>
            </div>

            <div class="vehicle-card">
                <div class="img-container">
                    <img src="/Image/Vehicle/ToyotaInnova.jpg" alt="Toyota Innova" />
                </div>
                <h4>Toyota Innova</h4>
                <p>Giá từ <strong>600.000đ/ngày</strong></p>
                <a href="VehicleList.aspx" class="btn-outline">Thuê ngay</a>
            </div>

            <div class="vehicle-card">
                <div class="img-container">
                    <img src="/Image/Vehicle/KiaCanival.jpg" alt="Kia Canival" />
                </div>
                <h4>Kia Canival</h4>
                <p>Giá từ <strong>900.000đ/ngày</strong></p>
                <a href="VehicleList.aspx" class="btn-outline">Thuê ngay</a>
            </div>
        </div>
    </section>

    <!-- PROCESS -->
    <section class="home-process">
        <h2>Thuê xe chỉ với 3 bước</h2>

        <div class="process-list">
            <div class="process-step">
                <span>1</span>
                <p>Chọn xe phù hợp</p>
            </div>

            <div class="process-step">
                <span>2</span>
                <p>Đặt lịch thuê</p>
            </div>

            <div class="process-step">
                <span>3</span>
                <p>Nhận xe & khởi hành</p>
            </div>
        </div>
    </section>
</asp:Content>
