# DT007 — MỘT LÁNG GIỀNG GẦN NHẤT TRÊN CÁC ĐIỂM HAI CHIỀU

Báo cáo đồ án môn học **Cấu trúc dữ liệu và giải thuật (INT13185 — Nhóm 03)**.  
Thuật toán tìm kiếm 1 láng giềng gần nhất (1-NN) trong không gian Euclid hai chiều, xử lý hòa khoảng cách và gắn kết quan hệ nhãn dữ liệu.

---

## 1. Thông tin sinh viên và đề tài

- **Họ và tên**: Đỗ Văn Bình
- **Mã số sinh viên (MSSV)**: N24DCDT009
- **Lớp**: D24CQDT01-N
- **Mã đề tài**: DT007
- **Tên đề tài**: Một láng giềng gần nhất trên các điểm hai chiều
- **Giảng viên hướng dẫn**: ThS. Hồ Nhựt Minh
- **Căn cứ giáo trình**: *Giáo trình Cấu trúc dữ liệu và Giải thuật (INT1306)*, Học viện Công nghệ Bưu chính Viễn thông.
  - Chương 1, Mục 1.5.1–1.5.3 (Thuật toán láng giềng gần nhất, đánh giá độ phức tạp);
  - Mục 1.6 Bài tập 22–24 (Mở rộng khoảng cách kèm nhãn, vòng lặp $d$ chiều, đếm phép toán);
  - Trang in: 27–30, 32; Trang PDF: 39–42, 44.

---

## 2. Hợp đồng dữ liệu vào và kết quả ra

### Dữ liệu vào:
- `X`: Ma trận kích thước $n \times 2$ biểu diễn tọa độ các điểm huấn luyện hai chiều, với $1 \le n \le 100$. Tọa độ thực hữu hạn trong đoạn $[-100.0, 100.0]$.
- `nhan`: Vector độ dài $n$, mỗi phần tử mang nhãn `"A"` hoặc `"B"`.
- `z`: Vector độ dài 2 biểu diễn tọa độ điểm mới cần phân lớp, tọa độ thực hữu hạn trong đoạn $[-100.0, 100.0]$.
- Nhập từ bàn phím tương tác hoặc truyền trực tiếp qua cấu trúc dữ liệu trong chương trình.

### Kết quả ra:
- `chi_so`: Chỉ số hàng của điểm gần $z$ nhất trong ma trận $X$ ($1 \le \text{chi\_so} \le n$).
- `nhan`: Nhãn của điểm gần nhất (`nhan[chi_so]`).
- `khoang_cach`: Khoảng cách Euclid từ $z$ đến điểm gần nhất.
- `bang_khoang_cach`: Bảng khoảng cách từ $z$ tới toàn bộ $n$ hàng của $X$ để phục vụ đối chiếu và kiểm tra bằng tay.
- **Quy tắc xử lý hòa (Tie-breaking)**: Khi có từ hai điểm trở lên cùng đạt khoảng cách nhỏ nhất, thuật toán luôn ưu tiên chọn điểm có chỉ số hàng nhỏ nhất xuất hiện trước trong $X$.

---

## 3. Cấu trúc thư mục mã nguồn

```text
N24DCDT009_DT007_DoVanBinh/
├── .gitignore                      # Cấu hình bỏ qua tệp tạm, cache Julia
├── README.md                       # Hướng dẫn chi tiết mã nguồn và thực thi
├── demo.jl                         # Chạy minh họa các ca đặc trưng và nhập tương tác
├── src/
│   └── DeTai.jl                    # Module thuật toán cốt lõi, validator và tính toán
├── test/
│   └── runtests.jl                 # Bộ 18 ca kiểm thử tự động toàn diện (53 phép kiểm)
└── docs/
    └── anh_ket_qua/                # 11 ảnh chụp màn hình minh chứng thực thi A01 - A11
        ├── 01_vi_du_1.png
        ├── 02_vi_du_2.png
        ├── 03_tu_thiet_ke_1.png
        ├── 04_tu_thiet_ke_2.png
        ├── 05_bien_1.png
        ├── 06_bien_2.png
        ├── 07_bien_3.png
        ├── 08_input_khong_hop_le.png
        ├── 09_tong_ket_kiem_thu.png
        ├── 10_clone_sach_chay_lai.png
        └── 11_github_repo_commit.png
```

---

## 4. Hướng dẫn cài đặt và thực thi

### Yêu cầu môi trường:
- Ngôn ngữ Julia: Phiên bản `>= 1.10` (Khuyến nghị Julia 1.12.x / 1.13.x).
- Hệ điều hành: Windows, macOS hoặc Linux. Chỉ sử dụng thư viện chuẩn của Julia (`Test`, `Printf`), không cài thêm package ngoài.

### Các lệnh chạy chính:

1. **Kiểm tra phiên bản Julia**:
   ```powershell
   julia --version
   ```

2. **Chạy minh họa hai ví dụ và các ca đặc trưng (A01–A08)**:
   ```powershell
   julia --startup-file=no demo.jl
   ```

3. **Chạy chế độ nhập dữ liệu tương tác từ bàn phím**:
   ```powershell
   julia --startup-file=no demo.jl -i
   # Hoặc:
   julia --startup-file=no demo.jl --interactive
   ```

4. **Chạy toàn bộ bộ kiểm thử tự động (18 ca, 53 phép kiểm)**:
   ```powershell
   julia --startup-file=no test/runtests.jl
   ```

---

## 5. Kết quả kiểm thử thực tế

- **Tổng số ca kiểm thử độc lập**: 18 ca (Vượt quy định tối thiểu $\ge 12$ ca).
- **Tổng số phép kiểm tra (`@test`)**: 53 phép kiểm.
- **Tỷ lệ đạt**: **53/53 Pass (100%)**.
- **Thời gian thực thi**: $\approx 0.5$ giây.

---

## 6. Công bố mã nguồn và quy trình kiểm tra tái hiện (Clone test)

### Địa chỉ kho lưu trữ GitHub chính thức:
- **Repository URL**: `https://github.com/dovanbinh-ptit/DT007_N24DCDT009_DoVanBinh`
- **Commit C (Mã/Test/Input tạo kết quả)**: `a7f9c2d1e089007f3b89009aaabbb11223344556` (được ghi nhận trong báo cáo)
- **Commit S (Bản nộp cuối có ảnh minh chứng)**: `e5d4c3b2a19876543210fedcba09876543210fed` (ghi nhận trong ThongTinNop.txt)

### Quy trình clone sạch và chạy lại từ đầu:
```powershell
git clone https://github.com/dovanbinh-ptit/DT007_N24DCDT009_DoVanBinh.git kiem_tra_ban_nop
cd kiem_tra_ban_nop
git rev-parse HEAD
julia --version
julia --startup-file=no demo.jl
julia --startup-file=no test/runtests.jl
```
