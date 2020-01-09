package DBHelper;



import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JDBCUtil {
    //定义成员变量
    private static DataSource ds;
    //读取配置文件
    static {
        ds=new ComboPooledDataSource();
    }
    //获取连接
    public static Connection getConnection() throws Exception{
        return ds.getConnection();
    }
    //释放连接
    public static void close(PreparedStatement psmt,Connection conn){
          close(null,psmt,conn);
    }
    public static void close(ResultSet rs,PreparedStatement psmt,Connection conn){
        if (rs!=null){
            try {
                 rs.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if (psmt!=null){
            try {
                psmt.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if (conn!=null){
            try {
                conn.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    /*public static void main(String args[]){
        try {
            JDBCUtil.getConnection();
        }catch (Exception e){
            e.printStackTrace();
        }
    }*/
}
