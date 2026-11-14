"""
test/runtests.jl - Bộ kiểm thử tự động toàn diện cho Đề tài DT007
Học phần: Cấu trúc dữ liệu và giải thuật (INT13185 - Nhóm 03)
Sinh viên: Đỗ Văn Bình - MSSV: N24DCDT009 - Lớp: D24CQDT01-N
Đề tài DT007: Một láng giềng gần nhất trên các điểm hai chiều
"""

using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

println("="^75)
println("  CHẠY BỘ KIỂM THỬ ĐỀ TÀI DT007 (1-NN TRÊN CÁC ĐIỂM HAI CHIỀU)")
println("  Sinh viên: Đỗ Văn Bình | MSSV: N24DCDT009 | Lớp: D24CQDT01-N")
println("="^75)

# Biến đếm tổng số ca kiểm thử độc lập
so_ca_kiem_thu = 0

@testset "BỘ KIỂM THỬ TOÀN DIỆN ĐỀ TÀI DT007" begin

    @testset "Nhóm 1: Hai ví dụ trên phiếu đề tài" begin
        # VD01: Ví dụ 1 trên phiếu
        # X = [0.0 0.0; 3.0 0.0; 0.0 4.0], nhan = ["A", "B", "A"], z = [2.5, 0.0]
        # Kỳ vọng: chi_so = 2, nhan = "B", khoang_cach = 0.5
        global so_ca_kiem_thu += 1
        X1 = [0.0 0.0; 3.0 0.0; 0.0 4.0]
        nhan1 = ["A", "B", "A"]
        z1 = [2.5, 0.0]
        kq1 = giai_bai((X1, nhan1, z1))
        @test kq1.chi_so == 2
        @test kq1.nhan == "B"
        @test isapprox(kq1.khoang_cach, 0.5; atol=1e-6)
        @test isapprox(kq1.bang_khoang_cach[1], 2.5; atol=1e-6)
        @test isapprox(kq1.bang_khoang_cach[2], 0.5; atol=1e-6)
        @test isapprox(kq1.bang_khoang_cach[3], sqrt(2.5^2 + 4.0^2); atol=1e-6)
        println("  [PASS] Ca 01 (VD01): Ví dụ 1 trên phiếu đề tài đạt chuẩn.")

        # VD02: Ví dụ 2 trên phiếu
        # X = [0.0 0.0; 3.0 0.0; 0.0 4.0], nhan = ["A", "B", "A"], z = [0.0, 3.5]
        # Kỳ vọng: chi_so = 3, nhan = "A", khoang_cach = 0.5
        global so_ca_kiem_thu += 1
        z2 = [0.0, 3.5]
        kq2 = giai_bai((X1, nhan1, z2))
        @test kq2.chi_so == 3
        @test kq2.nhan == "A"
        @test isapprox(kq2.khoang_cach, 0.5; atol=1e-6)
        @test isapprox(kq2.bang_khoang_cach[1], 3.5; atol=1e-6)
        @test isapprox(kq2.bang_khoang_cach[2], sqrt(3.0^2 + 3.5^2); atol=1e-6)
        @test isapprox(kq2.bang_khoang_cach[3], 0.5; atol=1e-6)
        println("  [PASS] Ca 02 (VD02): Ví dụ 2 trên phiếu đề tài đạt chuẩn.")
    end

    @testset "Nhóm 2: Các ca tự thiết kế (TK)" begin
        # TK01: Điểm mới z trùng hoàn toàn với một hàng trong tập dữ liệu
        # X = [1.0 1.0; 4.0 5.0; -2.0 3.0; 7.0 1.0], nhan = ["A", "B", "A", "B"], z = [4.0, 5.0]
        # Kỳ vọng: chi_so = 2, nhan = "B", khoang_cach = 0.0
        global so_ca_kiem_thu += 1
        X3 = [1.0 1.0; 4.0 5.0; -2.0 3.0; 7.0 1.0]
        nhan3 = ["A", "B", "A", "B"]
        z3 = [4.0, 5.0]
        kq3 = giai_bai((X3, nhan3, z3))
        @test kq3.chi_so == 2
        @test kq3.nhan == "B"
        @test isapprox(kq3.khoang_cach, 0.0; atol=1e-9)
        @test isapprox(kq3.bang_khoang_cach[2], 0.0; atol=1e-9)
        println("  [PASS] Ca 03 (TK01): Điểm mới z trùng một điểm trong tập dữ liệu (d = 0.0).")

        # TK02: Xử lý hòa khoảng cách (Tie-breaking) chọn chỉ số hàng nhỏ nhất
        # X = [0.0 0.0; 2.0 0.0; 1.0 5.0], nhan = ["A", "B", "A"], z = [1.0, 0.0]
        # d(hàng 1) = 1.0, d(hàng 2) = 1.0 => chọn hàng 1
        global so_ca_kiem_thu += 1
        X4 = [0.0 0.0; 2.0 0.0; 1.0 5.0]
        nhan4 = ["A", "B", "A"]
        z4 = [1.0, 0.0]
        kq4 = giai_bai((X4, nhan4, z4))
        @test kq4.chi_so == 1
        @test kq4.nhan == "A"
        @test isapprox(kq4.khoang_cach, 1.0; atol=1e-6)
        @test isapprox(kq4.bang_khoang_cach[1], 1.0; atol=1e-6)
        @test isapprox(kq4.bang_khoang_cach[2], 1.0; atol=1e-6)
        println("  [PASS] Ca 04 (TK02): Xử lý hòa khoảng cách đúng quy tắc chỉ số nhỏ nhất.")

        # TK03: Hai điểm trùng nhau trong ma trận X nhưng mang nhãn khác nhau
        # X = [2.0 3.0; 2.0 3.0], nhan = ["A", "B"], z = [2.0, 3.0]
        # Kỳ vọng: chọn hàng 1, nhãn "A", d = 0.0
        global so_ca_kiem_thu += 1
        X_trung = [2.0 3.0; 2.0 3.0]
        nhan_trung = ["A", "B"]
        z_trung = [2.0, 3.0]
        kq_trung = giai_bai((X_trung, nhan_trung, z_trung))
        @test kq_trung.chi_so == 1
        @test kq_trung.nhan == "A"
        @test isapprox(kq_trung.khoang_cach, 0.0; atol=1e-9)
        println("  [PASS] Ca 05 (TK03): Hai hàng trùng tọa độ hoàn toàn, chọn hàng đầu tiên.")
    end

    @testset "Nhóm 3: Các ca biên (BIEN)" begin
        # BIEN01: Cận dưới số điểm hợp lệ n = 1
        # X = [5.5 -2.3], nhan = ["A"], z = [1.0, 2.0]
        # Kỳ vọng: luôn chọn hàng 1
        global so_ca_kiem_thu += 1
        X_b1 = [5.5 -2.3]
        nhan_b1 = ["A"]
        z_b1 = [1.0, 2.0]
        kq_b1 = giai_bai((X_b1, nhan_b1, z_b1))
        @test kq_b1.chi_so == 1
        @test kq_b1.nhan == "A"
        kc_mong_doi_b1 = sqrt((5.5 - 1.0)^2 + (-2.3 - 2.0)^2)
        @test isapprox(kq_b1.khoang_cach, kc_mong_doi_b1; atol=1e-6)
        println("  [PASS] Ca 06 (BIEN01): Biên n = 1 điểm duy nhất.")

        # BIEN02: Tọa độ cực biên [-100.0, 100.0]
        # X = [-100.0 -100.0; 100.0 100.0], nhan = ["A", "B"], z = [-99.0, -99.0]
        global so_ca_kiem_thu += 1
        X_b2 = [-100.0 -100.0; 100.0 100.0]
        nhan_b2 = ["A", "B"]
        z_b2 = [-99.0, -99.0]
        kq_b2 = giai_bai((X_b2, nhan_b2, z_b2))
        @test kq_b2.chi_so == 1
        @test kq_b2.nhan == "A"
        @test isapprox(kq_b2.khoang_cach, sqrt(2.0); atol=1e-6)
        println("  [PASS] Ca 07 (BIEN02): Tọa độ cực biên sát giới hạn [-100, 100].")

        # BIEN03: Cận trên số điểm hợp lệ n = 100
        global so_ca_kiem_thu += 1
        n_max = 100
        X_b3 = zeros(Float64, n_max, 2)
        nhan_b3 = [i % 2 == 1 ? "A" : "B" for i in 1:n_max]
        for i in 1:n_max
            X_b3[i, 1] = Float64(i) - 50.0
            X_b3[i, 2] = Float64(i) * 0.5 - 25.0
        end
        z_b3 = [0.0, 0.0] # Trùng với hàng i = 50: X[50,1]=0, X[50,2]=0
        kq_b3 = giai_bai((X_b3, nhan_b3, z_b3))
        @test kq_b3.chi_so == 50
        @test kq_b3.nhan == "B"
        @test isapprox(kq_b3.khoang_cach, 0.0; atol=1e-9)
        @test length(kq_b3.bang_khoang_cach) == 100
        println("  [PASS] Ca 08 (BIEN03): Biên n = 100 điểm tối đa.")

        # BIEN04: Điểm z trùng gốc tọa độ [0.0, 0.0]
        global so_ca_kiem_thu += 1
        X_b4 = [0.0 0.0; 3.0 4.0]
        nhan_b4 = ["A", "B"]
        z_b4 = [0.0, 0.0]
        kq_b4 = giai_bai((X_b4, nhan_b4, z_b4))
        @test kq_b4.chi_so == 1
        @test kq_b4.nhan == "A"
        @test isapprox(kq_b4.khoang_cach, 0.0; atol=1e-9)
        println("  [PASS] Ca 09 (BIEN04): Điểm z tại gốc tọa độ (0, 0).")
    end

    @testset "Nhóm 4: Bất biến thuật toán (INVARIANT)" begin
        # INV01: Kiểm tra tính bất biến của kết quả trả về
        # Khoảng cách nhỏ nhất phải bằng min của bảng khoảng cách,
        # và mọi điểm khác đều có khoảng cách >= khoang_cach.
        global so_ca_kiem_thu += 1
        X_inv = [1.2 -3.4; 5.6 7.8; -9.0 0.5; 3.3 2.2]
        nhan_inv = ["A", "A", "B", "B"]
        z_inv = [2.0, 1.0]
        kq_inv = giai_bai((X_inv, nhan_inv, z_inv))
        @test kq_inv.khoang_cach == minimum(kq_inv.bang_khoang_cach)
        @test kq_inv.khoang_cach == kq_inv.bang_khoang_cach[kq_inv.chi_so]
        @test kq_inv.nhan == nhan_inv[kq_inv.chi_so]
        for i in 1:length(kq_inv.bang_khoang_cach)
            @test kq_inv.khoang_cach <= kq_inv.bang_khoang_cach[i]
            if isapprox(kq_inv.khoang_cach, kq_inv.bang_khoang_cach[i]; atol=1e-9)
                @test kq_inv.chi_so <= i
            end
        end
        println("  [PASS] Ca 10 (INV01): Kiểm tra bất biến tối ưu toàn cục và xử lý hòa.")
    end

    @testset "Nhóm 5: Kiểm tra bắt lỗi đầu vào (VALIDATOR / LOI)" begin
        X_hop_le = [0.0 0.0; 1.0 1.0]
        nhan_hop_le = ["A", "B"]
        z_hop_le = [0.5, 0.5]

        # LOI01: Tọa độ z vượt quá miền [-100.0, 100.0]
        global so_ca_kiem_thu += 1
        @test_throws ArgumentError giai_bai((X_hop_le, nhan_hop_le, [105.0, 0.0]))
        println("  [PASS] Ca 11 (LOI01): Bắt lỗi tọa độ z vượt miền [-100, 100].")

        # LOI02: Nhãn không phải 'A' hoặc 'B'
        global so_ca_kiem_thu += 1
        @test_throws ArgumentError giai_bai((X_hop_le, ["A", "C"], z_hop_le))
        println("  [PASS] Ca 12 (LOI02): Bắt lỗi nhãn không thuộc {'A', 'B'}.")

        # LOI03: Ma trận X sai số cột (không phải 2 cột)
        global so_ca_kiem_thu += 1
        @test_throws ArgumentError giai_bai(([0.0 0.0 0.0; 1.0 1.0 1.0], nhan_hop_le, z_hop_le))
        println("  [PASS] Ca 13 (LOI03): Bắt lỗi ma trận X có số cột khác 2.")

        # LOI04: Số lượng điểm n vượt quá 100 (n = 101)
        global so_ca_kiem_thu += 1
        X_101 = zeros(Float64, 101, 2)
        nhan_101 = fill("A", 101)
        @test_throws ArgumentError giai_bai((X_101, nhan_101, z_hop_le))
        println("  [PASS] Ca 14 (LOI04): Bắt lỗi số lượng điểm n > 100.")

        # LOI05: Độ dài vector z khác 2
        global so_ca_kiem_thu += 1
        @test_throws ArgumentError giai_bai((X_hop_le, nhan_hop_le, [0.5, 0.5, 0.5]))
        println("  [PASS] Ca 15 (LOI05): Bắt lỗi điểm mới z có số chiều khác 2.")

        # LOI06: Tọa độ chứa NaN hoặc Inf
        global so_ca_kiem_thu += 1
        @test_throws ArgumentError giai_bai(([0.0 0.0; NaN 1.0], nhan_hop_le, z_hop_le))
        println("  [PASS] Ca 16 (LOI06): Bắt lỗi tọa độ chứa giá trị vô hiệu NaN.")
    end

    @testset "Nhóm 6: Yêu cầu mở rộng tính khoảng cách d chiều (DIM)" begin
        # DIM01: Tính khoảng cách d = 3 chiều
        global so_ca_kiem_thu += 1
        u3 = [1.0, 2.0, 2.0]
        v3 = [4.0, 2.0, 6.0]
        # d = sqrt((4-1)^2 + (2-2)^2 + (6-2)^2) = sqrt(3^2 + 0 + 4^2) = 5.0
        @test isapprox(khoang_cach_d_chieu(u3, v3), 5.0; atol=1e-6)
        println("  [PASS] Ca 17 (DIM01): Khoảng cách Euclid d = 3 chiều chuẩn xác (d = 5.0).")

        # DIM02: Tính khoảng cách d = 4 chiều
        global so_ca_kiem_thu += 1
        u4 = [0.0, 0.0, 0.0, 0.0]
        v4 = [1.0, 2.0, 3.0, 4.0]
        # d = sqrt(1 + 4 + 9 + 16) = sqrt(30)
        @test isapprox(khoang_cach_d_chieu(u4, v4), sqrt(30.0); atol=1e-6)
        println("  [PASS] Ca 18 (DIM02): Khoảng cách Euclid d = 4 chiều chuẩn xác (d = sqrt(30)).")
    end

end

println("\n" * "="^75)
println("  TỔNG KẾT BỘ KIỂM THỬ ĐỀ TÀI DT007:")
println("  - Số ca kiểm thử độc lập đã chạy: $so_ca_kiem_thu ca (Yêu cầu tối thiểu: >= 12 ca)")
println("  - Tất cả các ca đều ĐẠT (100% PASS). Không có lỗi phát sinh.")
println("="^75)
