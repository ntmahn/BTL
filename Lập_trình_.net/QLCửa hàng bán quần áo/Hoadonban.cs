using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Rebar;
using System.IO;
using COMExcel = Microsoft.Office.Interop.Excel;

namespace QL_Cửa_hàng_bán_quần_áo
{
    public partial class Hoadonban : Form
    {
        public Hoadonban()
        {
            InitializeComponent();
        }

        private void Hoadonban_Load(object sender, EventArgs e)
        {
            Ketnoi.Connect();
            txtmahoadon.Enabled = false;
            LoadData();
            cbomasp.DataSource = Ketnoi.Getdatatotable("select* from tbl_ThongTinQuanAo");
            cbomasp.ValueMember = "MaQA";
            cbomasp.DisplayMember = "MaQA";
            cbomanv.DataSource = Ketnoi.Getdatatotable("select* from tbl_NhanVien");
            cbomanv.ValueMember = "MaNV";
            cbomanv.DisplayMember = "MaNV";
            cbomakh.DataSource = Ketnoi.Getdatatotable("select* from tbl_KhachHang");
            cbomakh.ValueMember = "MaKH";
            cbomakh.DisplayMember = "MaKH";
            cbomasp.Text = "";
            cbomanv.Text = "";
            cbomakh.Text = "";
            txtdongia.Text = "";
        }
        DataTable tblc1;
        public void LoadData()
        {
            string sql;
            sql = "select hdb.MaHDB,hdb.MaNV,hdb.MaKH,cthdb.MaQA,cthdb.SoLuong,hdb.NgayBan,hdb.DiaChi,hdb.SDT,cthdb.DonGia,cthdb.TongTien from tbl_HoaDonBan hdb join tbl_ChiTietHoaDonBan cthdb on hdb.MaHDB=cthdb.MaHDB";
            tblc1 = Ketnoi.Getdatatotable(sql);
            dgvhoadonban.DataSource = tblc1;
            dgvhoadonban.Columns[0].HeaderText = "Mã hóa đơn";
            dgvhoadonban.Columns[1].HeaderText = "Mã nhân viên";
            dgvhoadonban.Columns[2].HeaderText = "Mã khách hàng";
            dgvhoadonban.Columns[3].HeaderText = "Mã sản phẩm";
            dgvhoadonban.Columns[4].HeaderText = "Số lượng";
            dgvhoadonban.Columns[5].HeaderText = "Ngày bán";
            dgvhoadonban.Columns[6].HeaderText = "Địa chỉ";
            dgvhoadonban.Columns[7].HeaderText = "Số điện thoại";
            dgvhoadonban.Columns[8].HeaderText = "Đơn giá";
            dgvhoadonban.Columns[9].HeaderText = "Tổng tiền";
            dgvhoadonban.EditMode = DataGridViewEditMode.EditProgrammatically;
        }

        private void dgvhoadonban_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int i = e.RowIndex;
            txtmahoadon.Text = dgvhoadonban.Rows[i].Cells[0].Value.ToString().Trim();
            cbomanv.Text = dgvhoadonban.Rows[i].Cells[1].Value.ToString().Trim();
            cbomakh.Text = dgvhoadonban.Rows[i].Cells[2].Value.ToString().Trim();
            cbomasp.Text = dgvhoadonban.Rows[i].Cells[3].Value.ToString().Trim();
            txtsoluong.Text = dgvhoadonban.Rows[i].Cells[4].Value.ToString().Trim();
            mtbngayban.Text = dgvhoadonban.Rows[i].Cells[5].Value.ToString().Trim();
            txtdiachi.Text = dgvhoadonban.Rows[i].Cells[6].Value.ToString().Trim();
            txtsodienthoai.Text = dgvhoadonban.Rows[i].Cells[7].Value.ToString().Trim();
            txtdongia.Text = dgvhoadonban.Rows[i].Cells[8].Value.ToString().Trim();
            txttongtien.Text = dgvhoadonban.Rows[i].Cells[9].Value.ToString().Trim();
            soluongdau = double.Parse(txtsoluong.Text);
        }
        private void reset_data()
        {

            txtmahoadon.Text = "";
            cbomanv.Text = "";
            txtsoluong.Text = "";
            txtdongia.Text = "";
            cbomasp.Text = "";
            mtbngayban.Text = "";
            txttongtien.Text = "";
            txtsodienthoai.Text = "";
            cbomakh.Text = "";
            txtdiachi.Text = "";

        }

        private void btnLammoi_Click(object sender, EventArgs e)
        {
            txtmahoadon.Enabled = true;

            reset_data();
        }
        private double soluongdau;
        private double soluongsau;

        private void btnThem_Click(object sender, EventArgs e)
        {
            string sql = "select hdb.MaHDB from tbl_HoaDonBan hdb join tbl_ChiTietHoaDonBan cthdb on hdb.MaHDB=cthdb.MaHDB where hdb.MaHDB=N'" + txtmahoadon.Text.Trim() + "'";
            if (Ketnoi.checkey(sql))
            {
                if (txtsoluong.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập số lượng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtsoluong.Focus();
                    return;
                }
                if (cbomasp.Text == "")
                {
                    MessageBox.Show("Bạn chưa chọn mã sản phẩm", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    cbomasp.Focus();
                    return;
                }
                if (txtdongia.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập đơn giá", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtdongia.Focus();
                    return;
                }
                if (txttongtien.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập tổng tiền", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txttongtien.Focus();
                    return;
                }
                string sql1 = "select MaQA from tbl_ChiTietHoaDonBan  where MaQA=N'" + cbomasp.Text.Trim() + "'and MaHDB=N'" + txtmahoadon.Text + "'";
                if (Ketnoi.checkey(sql1))
                {
                    MessageBox.Show("Mã sản phẩm trong hóa đơn này đã có", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    cbomasp.Focus();
                    cbomasp.Text = "";
                    return;
                }
                else
                {
                    string updatesoluong = "update tbl_ThongTinQuanAo set soluong= soluong - N'" + txtsoluong.Text.Trim() + "' where MaQA = N'" + cbomasp.Text.Trim() + "'";
                    Ketnoi.runsql(updatesoluong);
                    string s = "insert into tbl_ChiTietHoaDonBan(MaHDB,MaQA,soluong,dongia,tongtien)values(N'" + txtmahoadon.Text.Trim() + "',N'" + cbomasp.Text.Trim() + "',N'" + txtsoluong.Text.Trim() + "',N'" + txtdongia.Text.Trim() + "',N'" + txttongtien.Text.Trim() + "')";
                    Ketnoi.runsql(s);
                    LoadData();
                    Hoadonban_Load(sender, e);
                    reset_data();
                    cbomasp.Text = "";
                }
            }
            else
            {
                if (txtmahoadon.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập mã hóa đơn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtmahoadon.Focus();
                    return;
                }
                if (cbomanv.Text == "")
                {
                    MessageBox.Show("Bạn chưa chọn mã nhân viên", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    cbomanv.Focus();
                    return;
                }
                if (txtsoluong.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập số lượng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtsoluong.Focus();
                    return;
                }
                if (cbomasp.Text == "")
                {
                    MessageBox.Show("Bạn chưa chọn mã sản phẩm", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    cbomasp.Focus();
                    return;
                }
                if (cbomakh.Text == "")
                {
                    MessageBox.Show("Bạn chưa chọn mã khách hàng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    cbomakh.Focus();
                    return;
                }
                if (mtbngayban.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập ngày bán", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    mtbngayban.Focus();
                    return;
                }
                if (txtdiachi.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập địa chỉ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtdiachi.Focus();
                    return;
                }
                if (txtsodienthoai.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập số điện thoại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtsodienthoai.Focus();
                    return;
                }
                if (txtdongia.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập đơn giá", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtdongia.Focus();
                    return;
                }
                if (txttongtien.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập tổng tiền", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txttongtien.Focus();
                    return;
                }
                string updatesoluong = "update tbl_ThongTinQuanAo set soluong= soluong - N'" + txtsoluong.Text.Trim() + "' where MaQA = N'" + cbomasp.Text.Trim() + "'";
                Ketnoi.runsql(updatesoluong);
                string sqlthem1 = "insert into tbl_HoaDonBan(MaHDB,manv,makh,ngayban,diachi,sdt)values(N'" + txtmahoadon.Text.Trim() + "',N'" + cbomanv.Text.Trim() + "',N'" + cbomakh.Text.Trim() + "',N'" + mtbngayban.Text.Trim() + "',N'" + txtdiachi.Text.Trim() + "',N'" + txtsodienthoai.Text.Trim() + "') ";
                string sqlthem2 = "insert into tbl_ChiTietHoaDonBan(MaHDB,MaQA,soluong,dongia,tongtien)values(N'" + txtmahoadon.Text.Trim() + "',N'" + cbomasp.Text.Trim() + "',N'" + txtsoluong.Text.Trim() + "',N'" + txtdongia.Text.Trim() + "',N'" + txttongtien.Text.Trim() + "')";
                Ketnoi.runsql(sqlthem1);
                Ketnoi.runsql(sqlthem2);
                LoadData();
                Hoadonban_Load(sender, e);
                reset_data();
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            if (tblc1.Rows.Count == 0)
            {
                MessageBox.Show("Không có dữ liệu", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (txtmahoadon.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập mã hóa đơn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtmahoadon.Focus();
                return;
            }
            if (cbomanv.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập mã nhân viên", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                cbomanv.Focus();
                return;
            }
            if (txtsoluong.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập số lượng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtsoluong.Focus();
                return;
            }
            if (cbomasp.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn mã sản phẩm", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                cbomasp.Focus();
                return;
            }
            if (cbomakh.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập mã khách hàng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                cbomakh.Focus();
                return;
            }
            if (mtbngayban.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập ngày bán", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                mtbngayban.Focus();
                return;
            }
            if (txtdiachi.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập địa chỉ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtdiachi.Focus();
                return;
            }
            if (txtsodienthoai.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập số điện thoại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtsodienthoai.Focus();
                return;
            }
            if (txtdongia.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập đơn giá", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtdongia.Focus();
                return;
            }
            if (txttongtien.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập tổng tiền", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txttongtien.Focus();
                return;
            }
             
            
            string sqlsua1 = "update tbl_HoaDonBan set MaKH=N'" + cbomakh.Text.Trim() + "',MaNV=N'" + cbomanv.Text.Trim() + "',ngayban=N'" + mtbngayban.Text.Trim() + "',diachi=N'" + txtdiachi.Text.Trim() + "',sdt=N'" + txtsodienthoai.Text.Trim() + "' where MaHDB=N'" + txtmahoadon.Text + "'";
            string sqlsua2 = "update tbl_ChiTietHoaDonBan set MaQA=N'" + cbomasp.Text.Trim() + "',soluong=N'" + txtsoluong.Text.Trim() + "',dongia=N'" + txtdongia.Text.Trim() + "',tongtien=N'" + txttongtien.Text.Trim() + "' where MaQA=N'" + cbomasp.Text + "'  and MaHDB=N'" + txtmahoadon.Text + "'";
            Ketnoi.runsql(sqlsua1);
            Ketnoi.runsql(sqlsua2);
            LoadData();
            soluongsau = double.Parse(txtsoluong.Text.Trim());
            double thaydoi = soluongdau-soluongsau;
            string updatesoluong = "update tbl_ThongTinQuanAo set SoLuong= soluong + " + thaydoi + "   where MaQA = N'" + cbomasp.Text + "'";
            Ketnoi.runsql(updatesoluong);

        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblc1.Rows.Count == 0)
            {
                MessageBox.Show("Không có dữ liệu", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (txtmahoadon.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            else if (MessageBox.Show("Bạn có muốn xóa không", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
            {
                DataTable a = Ketnoi.Getdatatotable("select * from tbl_HoaDonBan hdb join tbl_ChiTietHoaDonBan cthdb on hdb.MaHDB=cthdb.MaHDB where hdb.MaHDB=N'" + txtmahoadon.Text + "'");
                if (a.Rows.Count == 1)
                {
                    string updatesoluong = "update tbl_ThongTinQuanAo set soluong= soluong + N'" + txtsoluong.Text.Trim() + "' where MaQA = N'" + cbomasp.Text.Trim() + "'";
                    Ketnoi.runsql(updatesoluong);
                    string sqlxoa1 = "delete tbl_HoaDonBan where MaHDB=N'" + txtmahoadon.Text + "'";
                    string sqlxoa2 = "delete tbl_ChiTietHoaDonBan where MaHDB=N'" + txtmahoadon.Text + "'";
                    Ketnoi.runsql(sqlxoa1);
                    Ketnoi.runsql(sqlxoa2);
                    LoadData();
                    reset_data();
                }
                else
                {
                    string updatesoluong = "update tbl_ThongTinQuanAo set soluong= soluong + N'" + txtsoluong.Text.Trim() + "' where MaQA = N'" + cbomasp.Text.Trim() + "'";
                    Ketnoi.runsql(updatesoluong);
                    string sqlxoa2 = "delete tbl_ChiTietHoaDonBan where MaQA=N'" + cbomasp.Text + "' and MaHDB=N'" + txtmahoadon.Text + "'";
                    Ketnoi.runsql(sqlxoa2);
                    LoadData();
                    reset_data();
                    cbomasp.Text = "";

                }

            }
        }

        private void btnQuaylai_Click(object sender, EventArgs e)
        {
            Menu tc = new Menu();
            tc.Show();
            this.Hide();
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            DialogResult traloi;
            traloi = MessageBox.Show("Bạn có chắc muốn thoát không?", "Trả lời",
           MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
            if (traloi == DialogResult.OK)
                Application.Exit();
        }

        private void btnIn_Click(object sender, EventArgs e)
        {
            if (tblc1.Rows.Count == 0)
            {
                MessageBox.Show("Không có dữ liệu", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (txtmahoadon.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập mã hóa đơn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtmahoadon.Focus();
                return;
            }
            DialogResult traloi;
            traloi = MessageBox.Show("Bạn có chắc muốn in không?", "Trả lời",
           MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
            if (traloi == DialogResult.OK)
            {
                MessageBox.Show("In thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                // Khởi động chương trình Excel
                COMExcel.Application exApp = new COMExcel.Application();
                COMExcel.Workbook exBook; //Trong 1 chương trình Excel có nhiều Workbook
                COMExcel.Worksheet exSheet; //Trong 1 Workbook có nhiều Worksheet
                COMExcel.Range exRange;
                string sql;
                int hang = 0, cot = 0;
                DataTable tblThongtinHD, tblThongtinHang,tblTongTien, tblNV;
                exBook = exApp.Workbooks.Add(COMExcel.XlWBATemplate.xlWBATWorksheet);
                exSheet = exBook.Worksheets[1];
                // Định dạng chung
                exRange = exSheet.Cells[1, 1];
                exRange.Range["A1:B3"].Font.Size = 10;
                exRange.Range["A1:B3"].Font.Name = "Times new roman";
                exRange.Range["A1:B3"].Font.Bold = true;
                exRange.Range["A1:B3"].Font.ColorIndex = 5; //Màu xanh da trời
                exRange.Range["A1:A1"].ColumnWidth = 7;
                exRange.Range["B1:B1"].ColumnWidth = 15;
                exRange.Range["A1:B1"].MergeCells = true;
                exRange.Range["A1:B1"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignCenter;
                exRange.Range["A1:B1"].Value = "Shop Quần Áo Học Viện Ngân Hàng";

                exRange.Range["A2:B2"].MergeCells = true;
                exRange.Range["A2:B2"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignCenter;
                exRange.Range["A2:B2"].Value = "12 - Chùa Bộc - Đống Đa - Hà Nội";

                exRange.Range["A3:B3"].MergeCells = true;
                exRange.Range["A3:B3"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignCenter;
                exRange.Range["A3:B3"].Value = "Điện thoại: 0328680646";


                exRange.Range["C2:E2"].Font.Size = 16;
                exRange.Range["C2:E2"].Font.Name = "Times new roman";
                exRange.Range["C2:E2"].Font.Bold = true;
                exRange.Range["C2:E2"].Font.ColorIndex = 3; //Màu đỏ
                exRange.Range["C2:E2"].MergeCells = true;
                exRange.Range["C2:E2"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignCenter;
                exRange.Range["C2:E2"].Value = "HÓA ĐƠN BÁN";
                // Biểu diễn thông tin chung của hóa đơn bán
                sql = "select hdb.MaHDB,hdb.MaNV,hdb.MaKH,kh.TenKH,hdb.NgayBan,hdb.DiaChi,hdb.SDT from tbl_HoaDonBan hdb join tbl_Khachhang kh on hdb.MaKH=kh.MaKH where hdb.MaHDB=N'"+txtmahoadon.Text+"' and kh.MaKH=N'"+cbomakh.Text+"'";
                tblThongtinHD = Ketnoi.Getdatatotable(sql);
                exRange.Range["B6:C9"].Font.Size = 12;
                exRange.Range["B6:C9"].Font.Name = "Times new roman";
                exRange.Range["B6:B6"].Value = "Mã hóa đơn:";
                exRange.Range["C6:E6"].MergeCells = true;
                exRange.Range["C6:E6"].Value = tblThongtinHD.Rows[0][0].ToString();
                exRange.Range["B7:B7"].Value = " Tên khách hàng:";
                exRange.Range["C7:E7"].MergeCells = true;
                exRange.Range["C7:E7"].Value = tblThongtinHD.Rows[0][3].ToString();
                exRange.Range["B8:B8"].Value = "Địa chỉ:";
                exRange.Range["C8:E8"].MergeCells = true;
                exRange.Range["C8:E8"].Value = tblThongtinHD.Rows[0][5].ToString();
                exRange.Range["B9:B9"].Value = "Điện thoại:";
                exRange.Range["C9:E9"].MergeCells = true;
                exRange.Range["C9:E9"].Value = tblThongtinHD.Rows[0][6].ToString();
                sql = "SELECT sp.TenQA, cthdb.soluong, cthdb.dongia, cthdb.tongtien FROM tbl_ChiTietHoaDonBan cthdb join tbl_ThongTinQuanAo sp on sp.MaQA=cthdb.MaQA where MaHDB =N'"+txtmahoadon.Text+"' ";
                tblThongtinHang = Ketnoi.Getdatatotable(sql);
                exRange.Range["A11:F11"].Font.Bold = true;
                exRange.Range["A11:F11"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignCenter;
                exRange.Range["C11:F11"].ColumnWidth = 12;
                exRange.Range["A11:A11"].Value = "STT";
                exRange.Range["B11:B11"].Value = "Tên hàng";
                exRange.Range["C11:C11"].Value = "Số lượng";
                exRange.Range["D11:D11"].Value = "Đơn giá";
                exRange.Range["E11:E11"].Value = "Thành tiền";
                for (hang = 0; hang <= tblThongtinHang.Rows.Count - 1; hang++)
                {
                    //Điền số thứ tự vào cột 1 từ dòng 12
                    exSheet.Cells[1][hang + 12] = hang + 1;
                    for (cot = 0; cot <= tblThongtinHang.Columns.Count - 1; cot++)
                        //Điền thông tin hàng từ cột thứ 2, dòng 12
                        exSheet.Cells[cot + 2][hang + 12] = tblThongtinHang.Rows[hang][cot].ToString();
                }
                exRange = exSheet.Cells[cot][hang + 14];
                exRange.Font.Bold = true;
                exRange.Value2 = "Tổng tiền:";
                exRange = exSheet.Cells[cot + 1][hang + 14];
                exRange.Font.Bold = true;
                sql = "select sum(tongtien) as tongtien from tbl_ChiTietHoaDonBan where MaHDB=N'"+txtmahoadon.Text+"' ";
                tblTongTien = Ketnoi.Getdatatotable(sql);
                exRange.Value2 = tblTongTien.Rows[0][0].ToString();
                exRange = exSheet.Cells[1][hang + 15]; //Ô A1 
                exRange.Range["A1:F1"].MergeCells = true;
                exRange.Range["A1:F1"].Font.Bold = true;
                exRange.Range["A1:F1"].Font.Italic = true;
                exRange.Range["A1:F1"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignRight;
                exRange.Range["A1:F1"].Value = "Bằng chữ: " + Ketnoi.ChuyenSoSangChu(tblTongTien.Rows[0][0].ToString());
                exRange = exSheet.Cells[4][hang + 17]; //Ô A1 
                exRange.Range["A1:C1"].MergeCells = true;
                exRange.Range["A1:C1"].Font.Italic = true;
                exRange.Range["A1:C1"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignCenter;
                DateTime d = Convert.ToDateTime(tblThongtinHD.Rows[0][4]);
                exRange.Range["A1:C1"].Value = "Hà Nội, ngày " + d.Day + " tháng " + d.Month + " năm " + d.Year;
            exRange.Range["A2:C2"].MergeCells = true;
                exRange.Range["A2:C2"].Font.Italic = true;
                exRange.Range["A2:C2"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignCenter;
                exRange.Range["A2:C2"].Value = "Nhân viên bán hàng";
                exRange.Range["A6:C6"].MergeCells = true;
                exRange.Range["A6:C6"].Font.Italic = true;
                exRange.Range["A6:C6"].HorizontalAlignment = COMExcel.XlHAlign.xlHAlignCenter;
                sql = "SELECT nv.TenNV FROM tbl_HoaDonBan hdb join tbl_NhanVien nv on nv.MaNV=hdb.MaNV where nv.MaNV =N'" + cbomanv.Text + "' ";
                tblNV = Ketnoi.Getdatatotable(sql);
                exRange.Range["A6:C6"].Value = tblNV.Rows[0][0];
                exSheet.Name = "Hóa đơn nhập";
                exApp.Visible = true;

                
            }
        }

        private void txtsoluong_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtsoluong.Text) && !string.IsNullOrEmpty(txtdongia.Text))
            {

                int soLuong = int.Parse(txtsoluong.Text);
                decimal donGia = decimal.Parse(txtdongia.Text);
                decimal tongTien = soLuong * donGia;
                txttongtien.Text = tongTien.ToString();
            }
        }

        private void txtmahoadon_TextChanged(object sender, EventArgs e)
        {
            string sql = "select hdB.MaHDB from tbl_HoaDonBan hdb join tbl_ChiTietHoaDonBan cthdb on hdb.MaHDB=cthdb.MaHDB where hdb.MaHDB=N'" + txtmahoadon.Text.Trim() + "'";
            if (Ketnoi.checkey(sql))
            {
                cbomakh.DataSource = Ketnoi.Getdatatotable("select MaKH from tbl_HoaDonBan where MaHDB=N'" + txtmahoadon.Text.Trim() + "'");
                cbomakh.ValueMember = "MaKH";
                cbomakh.DisplayMember = "MaKH";
                cbomanv.DataSource = Ketnoi.Getdatatotable("select MaNV from tbl_HoaDonBan where MaHDB=N'" + txtmahoadon.Text.Trim() + "'");
                cbomanv.ValueMember = "MaNV";
                cbomanv.DisplayMember = "MaNV";
                string str;
                str = "SELECT ngayban FROM tbl_HoaDonBan WHERE MaHDB =N'" + txtmahoadon.Text.Trim() + "'";
                mtbngayban.Text = Ketnoi.GetFieldValues(str);

            }
        }

        private void txtdongia_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtsoluong.Text) && !string.IsNullOrEmpty(txtdongia.Text))
            {

                int soLuong = int.Parse(txtsoluong.Text);
                decimal donGia = decimal.Parse(txtdongia.Text);
                decimal tongTien = soLuong * donGia;
                txttongtien.Text = tongTien.ToString();
            }
        }

        private void cbomakh_TextChanged(object sender, EventArgs e)
        {
            string str;
            if (cbomakh.Text == "")
            {
                txtsodienthoai.Text = "";
            }
            // Khi kich chon Ma hang thi ten hang va gia ban se tu dong hien ra
            str = "SELECT sdt FROM tbl_KhachHang WHERE MaKH =N'" + cbomakh.Text.Trim() + "'";
            txtsodienthoai.Text = Ketnoi.GetFieldValues(str);
            str = "SELECT diachi FROM tbl_KhachHang WHERE MaKH =N'" + cbomakh.Text.Trim() + "'";
            txtdiachi.Text = Ketnoi.GetFieldValues(str);
        }

        private void cbomasp_TextChanged(object sender, EventArgs e)
        {
          if(cbomasp.Text !="")
            {
                string query1 = "select giaban*110/100 as giaban from tbl_ThongtinQuanAo where MaQA = N'" + cbomasp.Text + "'";
                string dongia = Ketnoi.GetFieldValues(query1);
                txtdongia.Text = dongia;

            }
        }
    }
}
