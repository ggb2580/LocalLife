package com.localguide.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.localguide.dto.LoginFormDTO;
import com.localguide.dto.Result;
import com.localguide.entity.UserInfo;

import javax.servlet.http.HttpSession;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ggb2580
 * @since 2025-12-30
 */
public interface IUserInfoService extends IService<UserInfo> {

    Result sendCode(String phone);


}
