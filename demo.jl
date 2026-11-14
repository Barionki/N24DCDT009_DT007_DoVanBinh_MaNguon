"""
demo.jl - Chương trình chạy minh họa Đề tài DT007
Học phần: Cấu trúc dữ liệu và giải thuật (INT13185 - Nhóm 03)
Sinh viên: Đỗ Văn Bình - MSSV: N24DCDT009 - Lớp: D24CQDT01-N
Đề tài DT007: Một láng giềng gần nhất trên các điểm hai chiều
"""

include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

function in_tieu_de()
    println("="^75)
    println("  HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG - CƠ SỞ TẠI TP. HỒ CHÍ MINH")
    println("  BÁO CÁO ĐỒ ÁN HỌC PHẦN: CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT (INT13185 - N03)")
    println("  ĐỀ TÀI DT007: MỘT LÁNG GIỀNG GẦN NHẤT TRÊN CÁC ĐIỂM HAI CHIỀU")
    println("  Sinh viên: Đỗ Văn Bình | MSSV: N24DCDT009 | Lớp: D24CQDT01-N")
    println("  Giảng viên hướng dẫn: Hồ Nhựt Minh")
    println("="^75)
end

function chay_minh_hoa_ca(ma_ca, ten_ca, X, nhan, z, ghi_chu)
    println("\n" * "-"^70)
    println("[$ma_ca] $ten_ca")
    println("-"^70)
    println("Ghi chú/Mục tiêu: $ghi_chu")
    n = size(X, 1)
    println("Dữ liệu vào:")
    println("  - Số điểm n = $n")
    println("  - Tập điểm X và nhãn:")
    for i in 1:n
        @printf("      Hàng %2d: (%6.2f, %6.2f) => Nhãn: %s\n", i, X[i, 1], X[i, 2], nhan[i])
    end
    @printf("  - Điểm mới z: (%6.2f, %6.2f)\n", z[1], z[2])

    ket_qua = giai_bai((X, nhan, z))

    println("Bảng khoảng cách Euclid từ z tới từng hàng:")
    for i in 1:n
        @printf("      Hàng %2d: d = %8.4f\n", i, ket_qua.bang_khoang_cach[i])
    end

    println("Kết quả chính:")
    @printf("  => Chỉ số hàng gần nhất : %d\n", ket_qua.chi_so)
    @printf("  => Nhãn dự đoán         : %s\n", ket_qua.nhan)
    @printf("  => Khoảng cách nhỏ nhất : %8.4f\n", ket_qua.khoang_cach)
    return ket_qua
end

function main()
    in_tieu_de()

    if length(ARGS) > 0 && (ARGS[1] == "--interactive" || ARGS[1] == "-i" || ARGS[1] == "--nhap-tay")
        du_lieu = nhap_tu_ban_phim()
        X, nhan, z = du_lieu
        chay_minh_hoa_ca("TAY", "Nhập trực tiếp từ bàn phím", X, nhan, z, "Dữ liệu người dùng nhập tương tác")
        return
    end

    println("\n>>> CHẾ ĐỘ CHẠY TỰ ĐỘNG CÁC CA ĐẶC TRƯNG MINH HỌA (A01 - A08) <<<")

    # 1. Ví dụ 1 trên phiếu (A01)
    X1 = [0.0 0.0; 3.0 0.0; 0.0 4.0]
    nhan1 = ["A", "B", "A"]
    z1 = [2.5, 0.0]
    chay_minh_hoa_ca("A01 / VD01", "Ví dụ 1 trên phiếu đề tài", X1, nhan1, z1,
                     "Điểm z=(2.5, 0) gần điểm (3, 0) ở hàng 2 nhất với khoảng cách 0.5")

    # 2. Ví dụ 2 trên phiếu (A02)
    X2 = [0.0 0.0; 3.0 0.0; 0.0 4.0]
    nhan2 = ["A", "B", "A"]
    z2 = [0.0, 3.5]
    chay_minh_hoa_ca("A02 / VD02", "Ví dụ 2 trên phiếu đề tài", X2, nhan2, z2,
                     "Điểm z=(0, 3.5) gần điểm (0, 4) ở hàng 3 nhất với khoảng cách 0.5")

    # 3. Ca tự thiết kế 1 (A03 / TK01)
    X3 = [1.0 1.0; 4.0 5.0; -2.0 3.0; 7.0 1.0]
    nhan3 = ["A", "B", "A", "B"]
    z3 = [4.0, 5.0]
    chay_minh_hoa_ca("A03 / TK01", "Ca tự thiết kế 1: Điểm mới z trùng hoàn toàn một điểm trong tập X", X3, nhan3, z3,
                     "z trùng hàng 2 => khoảng cách đúng bằng 0.0 và chọn hàng 2")

    # 4. Ca tự thiết kế 2 (A04 / TK02)
    X4 = [0.0 0.0; 2.0 0.0; 1.0 5.0]
    nhan4 = ["A", "B", "A"]
    z4 = [1.0, 0.0]
    chay_minh_hoa_ca("A04 / TK02", "Ca tự thiết kế 2: Xử lý hòa khoảng cách (Tie-breaking)", X4, nhan4, z4,
                     "z=(1, 0) cách đều hàng 1 (0, 0) và hàng 2 (2, 0) khoảng cách 1.0 => chọn hàng 1 (chỉ số nhỏ nhất)")

    # 5. Ca biên 1 (A05 / BIEN01)
    X5 = [5.5 -2.3]
    nhan5 = ["A"]
    z5 = [1.0, 2.0]
    chay_minh_hoa_ca("A05 / BIEN01", "Ca biên 1: Tập dữ liệu chỉ có duy nhất 1 điểm (n = 1)", X5, nhan5, z5,
                     "n = 1 là cận dưới số điểm hợp lệ; hàng 1 luôn luôn được chọn")

    # 6. Ca biên 2 (A06 / BIEN02)
    X6 = [-100.0 -100.0; 100.0 100.0]
    nhan6 = ["A", "B"]
    z6 = [-99.0, -99.0]
    chay_minh_hoa_ca("A06 / BIEN02", "Ca biên 2: Tọa độ ở biên giới hạn không gian [-100, 100]", X6, nhan6, z6,
                     "Kiểm tra tính chính xác với các giá trị tọa độ sát ngưỡng biên cho phép")

    # 7. Ca biên 3 (A07 / BIEN03)
    n_max = 100
    X7 = zeros(Float64, n_max, 2)
    nhan7 = [i % 2 == 1 ? "A" : "B" for i in 1:n_max]
    for i in 1:n_max
        X7[i, 1] = Float64(i) - 50.0
        X7[i, 2] = Float64(i) * 0.5 - 25.0
    end
    z7 = [0.0, 0.0]
    chay_minh_hoa_ca("A07 / BIEN03", "Ca biên 3: Số lượng điểm đạt tối đa theo hợp đồng (n = 100)", X7, nhan7, z7,
                     "Kiểm tra thuật toán xử lý trơn tru với kích thước dữ liệu lớn nhất n = 100")

    # 8. Ca kiểm tra input không hợp lệ (A08 / LOI01)
    println("\n" * "-"^70)
    println("[A08 / LOI01] Kiểm tra cơ chế từ chối dữ liệu không hợp lệ của Validator")
    println("-"^70)
    println("Thử nghiệm 1: Điểm z có tọa độ vượt quá miền [-100.0, 100.0] (z = [150.0, 0.0])")
    try
        giai_bai((X1, nhan1, [150.0, 0.0]))
    catch e
        println("  => [PASS] Đã bắt ngoại lệ dự kiến: ", e.msg)
    end

    println("Thử nghiệm 2: Nhãn không phải 'A' hoặc 'B' (nhan = [\"A\", \"C\", \"A\"])")
    try
        giai_bai((X1, ["A", "C", "A"], z1))
    catch e
        println("  => [PASS] Đã bắt ngoại lệ dự kiến: ", e.msg)
    end

    println("\n" * "="^75)
    println("  HOÀN THÀNH CHẠY MINH HỌA TẤT CẢ CÁC CA ĐẶC TRƯNG.")
    println("  Để chạy bộ kiểm thử tự động toàn diện, chạy lệnh: julia test/runtests.jl")
    println("="^75)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
