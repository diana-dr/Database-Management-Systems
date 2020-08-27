using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Assignment1
{
    public partial class Form1 : Form
    {

        SqlDataAdapter daType, daProduct;
        DataSet dataSet;
        SqlCommandBuilder cb;
        BindingSource bsType, bsProduct;
        SqlConnection dbConn = new SqlConnection("Data Source = DESKTOP-EQH0NVU\\SQLEXPRESS; Initial Catalog = Brewery; Integrated Security = true;");


        public Form1()
        {
            InitializeComponent();
            dataSet = new DataSet();
            daType = new SqlDataAdapter("SELECT * FROM ProductTypes", dbConn);
            daProduct = new SqlDataAdapter("SELECT * FROM Product", dbConn);
            cb = new SqlCommandBuilder(daProduct);

            daType.Fill(dataSet, "ProductTypes");
            daProduct.Fill(dataSet, "Product");
            
            DataRelation dr = new DataRelation("FK__Product__typeID__398D8EEE",
            dataSet.Tables["ProductTypes"].Columns["typeID"],
            dataSet.Tables["Product"].Columns["typeID"]);
            
            dataSet.Relations.Add(dr);
            
            //data binding
            
            bsType = new BindingSource();
            bsType.DataSource = dataSet;
            bsType.DataMember = "ProductTypes";
            
            bsProduct = new BindingSource();
            bsProduct.DataSource = bsType;
            bsProduct.DataMember = "FK__Product__typeID__398D8EEE";
            
            dgvProductTypes.DataSource = bsType;
            dgvProduct.DataSource = bsProduct;

            cb.GetUpdateCommand();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void btnUpdateDB_Click(object sender, EventArgs e)
        {
            daProduct.Update(dataSet, "Product");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            daProduct.Update(dataSet, "Product");
        }

        private void deleteButton_Click(object sender, EventArgs e)
        {
            int selectedIndex = dgvProductTypes.SelectedRows[0].Index;

            int typeID = int.Parse(dgvProductTypes[0, selectedIndex].Value.ToString());
            string sql = "DELETE FROM Product WHERE typeID = @typeID";

            SqlCommand deleteRecord = new SqlCommand();
            deleteRecord.Connection = dbConn;
            deleteRecord.CommandType = CommandType.Text;
            deleteRecord.CommandText = sql;

            SqlParameter RowParameter = new SqlParameter();
            RowParameter.ParameterName = "@typeID";
            RowParameter.SqlDbType = SqlDbType.Int;
            RowParameter.IsNullable = false;
            RowParameter.Value = typeID;

            deleteRecord.Parameters.Add(RowParameter);

            deleteRecord.Connection.Open();

            deleteRecord.ExecuteNonQuery();

            deleteRecord.Connection.Close();
            daProduct.Update(dataSet, "Product");

        }

        private void dgvProduct_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvProductTypes_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
