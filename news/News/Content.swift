//
//  Content.swift
//  News
//
//  Created by 郭 俊兵 on 15/10/4.
//  Copyright © 2015年 jack. All rights reserved.
//

import Foundation

//体育新闻列表
let  TIYU_NEWS_LIST = "http://apis.baidu.com/txapi/tiyu/tiyu"

//国际新闻列表
let  GUOJI_NEWS_LIST = "http://apis.baidu.com/txapi/world/world"

// appkey
let  MY_KEY = "19fee1afd34f31fbd5f6a64c1d8d1b7a"

// isfirst
var  IS_FIRST = false



// MARK: 文章接口

// 获取文章列表
let GET_ARTICLE = "http://api.itjh.net/v1/ArticleServer/queryArticleListByNew/"

// 根据文章ID获取电影详情
var GET_ARTICLE_ID = "http://api.itjh.net/v1/ArticleServer/queryArticleById/"

// 根据分类获取文章列表
var GET_ARTICLE_CATEGORY = "http://api.itjh.net/v1/ArticleServer/queryArticleListByCategory/"

// MARK: 用户接口

//第三方用户登录接口 POST方式
var login = "http://api.itjh.net/v1/PeopleServer/saveUser/"
