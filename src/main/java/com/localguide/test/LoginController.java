package com.localguide.test;

import com.localguide.dto.LoginFormDTO;
import com.localguide.dto.Result;
import com.localguide.dto.UserDTO;
import com.localguide.utils.UserHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
//@RequestMapping("/user")
public class LoginController {
    @Autowired
    LoginService loginService;

    /**
     * 获取验证码
     * @param phone
     * @return
     */
    @PostMapping("/code")
    public Result getCode(@RequestParam String phone){
        return loginService.getCode(phone);
    }

    //登录
    @PostMapping("/login")
    public Result login(@RequestBody LoginFormDTO loginFormDTO){
        return loginService.login(loginFormDTO);
    }

    //
    @GetMapping("/me")
    public Result me(){
        // TODO 获取当前登录的用户并返回
        UserDTO user = UserHolder.getUser();
        return Result.ok(user);
    }
}
