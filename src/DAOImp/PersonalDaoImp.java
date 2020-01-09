package DAOImp;

import DAO.PersonalDao;
import Utils.DBUtils;
import model.AccountInformation;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class PersonalDaoImp implements PersonalDao {
    @Override
    public String queryPasswordByUid(int uid, String password) {
        return DBUtils.queryPasswordByUid(uid,password);
    }

    @Override
    public void changePassword(int uid,String password) {
        DBUtils.changePassword(uid,password);
    }

    @Override
    public void updatePersonal(String major, String name, String grade,int uid) {
        DBUtils.updatePersonal(major,name,grade,uid);
    }

    @Override
    public JSONObject querypInfoByUid(int uid){
        return JSONObject.fromObject(DBUtils.querypInfoByUid(uid));
    }
}
