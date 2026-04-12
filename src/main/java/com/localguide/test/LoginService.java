package com.localguide.test;

import com.localguide.dto.LoginFormDTO;
import com.localguide.dto.Result;

public interface LoginService {
    Result getCode(String phone);

    Result login(LoginFormDTO loginFormDTO);
}
