package com.localguide.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.localguide.dto.LoginFormDTO;
import com.localguide.dto.Result;
import com.localguide.entity.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
public interface IUserService extends IService<User> {
    Result login(LoginFormDTO loginForm, HttpServletRequest request);

    Result sign();

    Result signCount();
}
