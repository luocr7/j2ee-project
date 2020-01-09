package DAO;

import model.AccountInformation;
import net.sf.json.JSONObject;

public interface PersonalDao {
    public void updatePersonal(String major,String name,String grade,int uid);
    public void changePassword(int uid,String password);
    public String queryPasswordByUid(int uid,String password);
    public JSONObject querypInfoByUid(int uid);
}
