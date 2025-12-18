<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="CarRental.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        /* ===== CONTACT PAGE ===== */

        .contact-banner {
            background: #333;
            color: white;
            padding: 80px 20px;
            text-align: center;
        }

            .contact-banner h1 {
                font-size: 36px;
                margin-bottom: 10px;
            }

            .contact-banner p {
                color: #dbeafe;
                font-size: 16px;
            }

        /* CONTENT */
        .contact-section {
            padding: 70px 20px;
        }

        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            gap: 50px;
        }

        .contact-info h2,
        .contact-form h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }

        .contact-info p {
            margin-bottom: 14px;
            font-size: 16px;
            color: #374151;
        }

        .contact-info i {
            color: #2563eb;
            margin-right: 10px;
        }

        /* FORM */
        .contact-form {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        }

        .contact-input {
            width: 100%;
            padding: 14px 16px;
            margin-bottom: 16px;
            border-radius: 10px;
            border: 1px solid #d1d5db;
            font-size: 15px;
        }

            .contact-input:focus {
                outline: none;
                border-color: #2563eb;
            }

            .contact-input.textarea {
                height: 140px;
                resize: none;
            }

        .btn-primary {
            background: #2563eb;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s ease;
        }

            .btn-primary:hover {
                background: #1d4ed8;
            }
        /* Responsive */
        @media (max-width: 768px) {
            .contact-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BANNER -->
    <section class="contact-banner">
        <h1>Liên hệ với chúng tôi</h1>
        <p>Chúng tôi luôn sẵn sàng hỗ trợ bạn</p>
    </section>

    <!-- CONTACT CONTENT -->
    <section class="contact-section">
        <div class="contact-container">

            <!-- INFO -->
            <div class="contact-info">
                <h2>Thông tin liên hệ</h2>

                <p>
                    <i class="fa-solid fa-location-dot"></i>
                    Cao Lãnh, Đồng Tháp
                </p>

                <p>
                    <i class="fa-solid fa-phone"></i>
                    0909 123 456
                </p>

                <p>
                    <i class="fa-solid fa-envelope"></i>
                    support@chothuexe3conca.vn
                </p>

                <p>
                    <i class="fa-solid fa-clock"></i>
                    24/24H (T2 – CN)
                </p>
            </div>

            <!-- FORM -->
            <div class="contact-form">
                <h2>Gửi tin nhắn</h2>

                <asp:TextBox ID="txtName" runat="server"
                    CssClass="contact-input" placeholder="Họ và tên" />

                <asp:TextBox ID="txtEmail" runat="server"
                    CssClass="contact-input" placeholder="Email" />

                <asp:TextBox ID="txtMessage" runat="server"
                    CssClass="contact-input textarea"
                    TextMode="MultiLine"
                    placeholder="Nội dung liên hệ" />

                <asp:Button ID="btnSend" runat="server"
                    Text="Gửi liên hệ"
                    CssClass="btn-primary" />

            </div>

        </div>
    </section>
</asp:Content>
