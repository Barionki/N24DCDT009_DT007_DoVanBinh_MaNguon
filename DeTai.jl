"""
Module DeTai - Đề tài DT007: Một láng giềng gần nhất trên các điểm hai chiều
Học phần: Cấu trúc dữ liệu và giải thuật (INT13185 - Nhóm 03)
Sinh viên thực hiện: Đỗ Văn Bình - MSSV: N24DCDT009 - Lớp: D24CQDT01-N
Giảng viên hướng dẫn: Hồ Nhựt Minh
"""
module DeTai

export kiem_tra_dau_vao, khoang_cach, khoang_cach_d_chieu,
       bang_khoang_cach, mot_lang_gieng, giai_bai, nhap_tu_ban_phim

"""
    khoang_cach(u, v)

Tính khoảng cách Euclid giữa hai điểm hai chiều `u` và `v`.
Công thức: d = sqrt((u[1] - v[1])^2 + (u[2] - v[2])^2)
"""
function khoang_cach(u, v)
    dx = Float64(u[1]) - Float64(v[1])
    dy = Float64(u[2]) - Float64(v[2])
    return sqrt(dx * dx + dy * dy)
end

"""
    khoang_cach_d_chieu(u, v)

Yêu cầu thêm tùy chọn theo phiếu: tính khoảng cách Euclid giữa hai điểm trong không
gian d chiều bằng vòng lặp, kiểm tra hai vector có cùng kích thước d >= 1.
"""
function khoang_cach_d_chieu(u, v)
    if length(u) != length(v)
        throw(ArgumentError("Hai vector phai co cung so chieu (length(u) != length(v))"))
    end
    d = length(u)
    if d < 1
        throw(ArgumentError("So chieu phai lon hon hoac bang 1"))
    end
    tong_binh_phuong = 0.0
    for k in 1:d
        hieu = Float64(u[k]) - Float64(v[k])
        tong_binh_phuong += hieu * hieu
    end
    return sqrt(tong_binh_phuong)
end

"""
    kiem_tra_dau_vao(X, nhan, z)

Kiểm tra tính hợp lệ của dữ liệu đầu vào theo đúng hợp đồng của đề tài DT007:
- X là ma trận n x 2 với 1 <= n <= 100.
- Tọa độ các điểm trong X là số thực hữu hạn trong [-100.0, 100.0].
- nhan là mảng 1D độ dài n, các phần tử chỉ gồm nhãn "A" hoặc "B".
- z là vector độ dài 2, tọa độ thực hữu hạn trong [-100.0, 100.0].
Nếu dữ liệu không hợp lệ, ném ngoại lệ ArgumentError kèm mô tả chi tiết.
"""
function kiem_tra_dau_vao(X, nhan, z)
    # Kiểm tra kích thước ma trận X
    if ndims(X) != 2 || size(X, 2) != 2
        throw(ArgumentError("X phai la ma tran 2 chieu kich thuoc n x 2 (hien tai size = $(size(X)))"))
    end
    n = size(X, 1)
    if n < 1 || n > 100
        throw(ArgumentError("So luong diem n phai thoa man 1 <= n <= 100 (hien tai n = $n)"))
    end

    # Kiểm tra tọa độ X
    for i in 1:n
        for j in 1:2
            val = Float64(X[i, j])
            if isnan(val) || isinf(val)
                throw(ArgumentError("Toa do X[$i, $j] khong hop le: chua gia tri NaN hoac Inf"))
            end
            if val < -100.0 || val > 100.0
                throw(ArgumentError("Toa do X[$i, $j] = $val nam ngoai mien [-100.0, 100.0]"))
            end
        end
    end

    # Kiểm tra vector nhan
    if length(nhan) != n
        throw(ArgumentError("Do dai mang nhan ($(length(nhan))) khong khop voi so hang cua X ($n)"))
    end
    for i in 1:n
        lbl = string(nhan[i])
        if lbl != "A" && lbl != "B"
            throw(ArgumentError("Nhan tai vi tri $i la '$lbl' khong hop le; chi chap nhan 'A' hoac 'B'"))
        end
    end

    # Kiểm tra vector z
    if length(z) != 2
        throw(ArgumentError("Vector diem moi z phai co do dai dung bang 2 (hien tai length = $(length(z)))"))
    end
    for j in 1:2
        val_z = Float64(z[j])
        if isnan(val_z) || isinf(val_z)
            throw(ArgumentError("Toa do z[$j] khong hop le: chua gia tri NaN hoac Inf"))
        end
        if val_z < -100.0 || val_z > 100.0
            throw(ArgumentError("Toa do z[$j] = $val_z nam ngoai mien [-100.0, 100.0]"))
        end
    end

    return true
end

"""
    bang_khoang_cach(X, z)

Tính khoảng cách Euclid từ điểm mới `z` tới từng hàng của ma trận `X`.
Trả về vector chứa n khoảng cách.
"""
function bang_khoang_cach(X, z)
    n = size(X, 1)
    danh_sach_kc = Vector{Float64}(undef, n)
    for i in 1:n
        u = [X[i, 1], X[i, 2]]
        danh_sach_kc[i] = khoang_cach(u, z)
    end
    return danh_sach_kc
end

"""
    mot_lang_gieng(X, nhan, z)

Tìm một láng giềng gần nhất của điểm mới `z` trong tập các điểm `X` đã gắn `nhan`.
Xử lý hòa: Nếu có nhiều điểm cùng khoảng cách nhỏ nhất, ưu tiên chọn chỉ số hàng nhỏ nhất.
Trả về NamedTuple: `(chi_so = ..., nhan = ..., khoang_cach = ...)`.
"""
function mot_lang_gieng(X, nhan, z)
    n = size(X, 1)
    kc_nho_nhat = Inf
    chi_so_tot_nhat = 0
    nhan_tot_nhat = ""

    for i in 1:n
        u = [X[i, 1], X[i, 2]]
        kc = khoang_cach(u, z)
        # Sử dụng so sánh nhỏ hơn nghiêm ngặt (<) để khi hòa khoảng cách,
        # chỉ số hàng nhỏ nhất ban đầu được giữ nguyên.
        if kc < kc_nho_nhat
            kc_nho_nhat = kc
            chi_so_tot_nhat = i
            nhan_tot_nhat = string(nhan[i])
        end
    end

    return (chi_so = chi_so_tot_nhat, nhan = nhan_tot_nhat, khoang_cach = kc_nho_nhat)
end

"""
    giai_bai(du_lieu)

Giao diện thống nhất giải bài toán:
Tham số `du_lieu` là tuple `(X, nhan, z)`.
Kiểm tra tính hợp lệ của đầu vào, sau đó thực hiện tìm láng giềng gần nhất
và tính bảng khoảng cách tới từng hàng.
"""
function giai_bai(du_lieu)
    if !(du_lieu isa Tuple) || length(du_lieu) != 3
        throw(ArgumentError("du_lieu phai la Tuple (X, nhan, z) gom 3 thanh phan"))
    end
    X, nhan, z = du_lieu
    kiem_tra_dau_vao(X, nhan, z)

    ket_qua = mot_lang_gieng(X, nhan, z)
    bang_kc = bang_khoang_cach(X, z)

    return (
        chi_so = ket_qua.chi_so,
        nhan = ket_qua.nhan,
        khoang_cach = ket_qua.khoang_cach,
        bang_khoang_cach = bang_kc
    )
end

"""
    nhap_tu_ban_phim()

Hỗ trợ nhập dữ liệu tương tác từ bàn phím đúng theo yêu cầu đề bài.
"""
function nhap_tu_ban_phim()
    println("--- NHAP DU LIEU TU BAN PHIM (DT007: 1-NN 2D) ---")
    print("Nhap so luong diem n (1 <= n <= 100): ")
    n_str = readline()
    n = parse(Int, strip(n_str))

    X = Matrix{Float64}(undef, n, 2)
    nhan = Vector{String}(undef, n)

    println("Nhap toa do tung diem (x y) va nhan (A hoac B), cach nhau boi dau cach:")
    for i in 1:n
        print("  Diem $i (x y nhan): ")
        line = split(strip(readline()))
        X[i, 1] = parse(Float64, line[1])
        X[i, 2] = parse(Float64, line[2])
        nhan[i] = string(line[3])
    end

    print("Nhap toa do diem moi z (x y): ")
    z_line = split(strip(readline()))
    z = [parse(Float64, z_line[1]), parse(Float64, z_line[2])]

    du_lieu = (X, nhan, z)
    kiem_tra_dau_vao(X, nhan, z)
    return du_lieu
end

end # module DeTai
