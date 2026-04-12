package com.localguide.controller;


import com.localguide.dto.Result;
import com.localguide.service.IFollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
@RestController
@RequestMapping("/follow")
public class FollowController {

    @Autowired
    private IFollowService followService;
    @PutMapping("/{id}/{isFollow}")
    public Result follow(@PathVariable("id") Long followUserId ,@PathVariable Boolean isFollow){
       return followService.follow(followUserId,isFollow);
    }

    @GetMapping("/or/not/{id}")
    public Result follow(@PathVariable("id") Long followUserId){
        return followService.isFollow(followUserId);
    }
}
