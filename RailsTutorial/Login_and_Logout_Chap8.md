#无效的表单
##会话控制器
登录和退出功能由会话控制器中的相应动作处理,登录表单在new动作中处理(本节的内容),登录的过程是向create动作发送POST请求(8.2 节),退出则是向destroy动作发送DELETE请求.
`rails g controller Sessions new`
*config/routes.rb*
```rails
get 'login' => 'sessions#new'
post 'login' => 'sessions#create'
delete 'logout' => 'sessions#destroy'
```
##登录表单
*sessions/new.html.erb*界面添加表单，用来提交和显示login信息。

**form_for(@user) 的作用是让表单向 /users 发起 POST 请求。对会话来说，我们需要指明资源的名字以及相应的 URL**
```rails
form_for(:session, url: login_path)
```
*sessions/new.html.erb*
```
<% provide(:title, "Log in") %>
<h1>Log in</h1>

<div class="row">
  <div class="col-md-6 col-md-offset-3">
    <%= form_for(:session, url: login_path) do |f| %>

      <%= f.label :email %>
      <%= f.email_field :email %>

      <%= f.label :password %>
      <%= f.password_field :password %>

      <%= f.submit "Log in", class: "btn btn-primary" %>
    <% end %>

    <p>New user? <%= link_to "Sign up now!", signup_path %></p>
  </div>
</div>
```
##查找并认证用户
form提交之后，是一个嵌套的hash。params包含如下嵌套hash
`{ session: { password: "foobar", email: "skdj@sak.com" }}`
`params[:session]` : `{ password: "foobar", email: "skdj@sak.com"}`
so.`params[:sessions][:email]`是提交的电子邮件
```rails
def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 登入用户，然后重定向到用户的资料页面
    else
      # 创建一个错误消息
      render 'new'
    end
  end
```
`find_by`成功返回：user的hash，没有找到则返回nil
`user.authenticate`若密码一样，则返回：user的hash
###&&的解释
`user`为空，nil && 为nil，则不进行`authenticate`方法，返回`false`.

`user`有返回值，但是，user.authenticate验证不通过，返回`false`，整体为`false`

`user`有返回值，user.authenticate有返回值，返回：user的hash。除了`nil`和`false`之外，所有对象都视作true，整体返回`true`
##渲染闪现消息
在 7.3.3 节，我们使用用户模型的验证错误显示注册失败时的错误消息。这些错误关联在某个 Active Record 对象上，不过现在不能使用这种方式了，因为会话不是 Active Record 模型。我们要采取的方法是，登录失败时，在闪现消息中显示消息。
```
flash[:danger] = 'Invalid email/password combination' # 不完全正确
```
##测试闪现消息
`$ rails generate integration_test users_login`

*test/integration/users_login_test.rb*
```
require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

```
**测试步骤:**

1. 访问登录页面；
2. 确认正确渲染了登录表单；
3. 提交无效的 params 哈希，向登录页面发起 post 请求；
4. 确认重新渲染了登录表单，而且显示了一个闪现消息；
5. 访问其他页面（例如首页）；
6. 确认这个页面中没显示前面那个闪现消息。

只测试单个文件的方法：
`bundle exec rake test TEST=test/integration/users_login_test.rb`

**变绿方法:**

`flash.now[:danger] = 'Invalid email/password combination'`
`flash.now` 专门用于在重新渲染的页面中显示闪现消息.

#有效的表单
本节通过临时会话让用户登录，浏览器关闭后会话自动失效。

8.4 节会实现持久会话，即便浏览器关闭，依然处于登录状态。

如果在控制器的基类（ApplicationController）中引入辅助方法模块，还可以在控制器中使用,**辅助方法模块会自动引入 Rails 视图**.

*app/controllers/application_controller.rb*

`include SessionsHelper`

# session[:user_id] 和 session.user_id的区别？
model的实例可以使用`.`号获取属性。

hash只能用[:key]获取。

`session`方法创建的临时 cookie 会自动加密，**此处的session是rails提供的方法，不是session控制器。**

*app/helpers/sessions_helper.rb*

```
module SessionsHelper

  # 登入指定的用户
  def log_in(user)
    session[:user_id] = user.id
  end
end
```

*app/controllers/sessions_controller.rb*

```
      log_in user
      redirect_to user
```

`redirect_to user`rails会自动把地址转换成当前用户资料页的地址:`user_url(user)`

##当前用户
*app/helpers/sessions_helper.rb*

```
  # 返回当前登录的用户（如果有的话）
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
```
##修改布局中的链接
*app/helpers/sessions_helper.rb*

```
  # 如果用户已登录，返回 true，否则返回 false
  def logged_in?
    !current_user.nil?
  end
```
##测试布局中的变化
测试步骤：
1. 访问登录页面；
2. 通过 post 请求发送有效的登录信息；
3. 确认登录链接消失了；
4. 确认出现了退出链接；
5. 确认出现了资料页面链接。

```
  test "login with valid information" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
```

`assert_redirected_to @user` 检查重定向的地址是否正确；

使用 follow_redirect! 访问重定向的目标地址。

还确认页面中有零个登录链接，从而确认登录链接消失了。

#退出
*app/helpers/sessions_helper.rb*

```
  # 退出当前用户
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
```
*app/controllers/sessions_controller.rb*
```
  def destroy
    log_out
    redirect_to root_url
  end
```
##记忆令牌和摘要
经过上述分析，我们计划按照下面的方式实现持久会话：
1. 生成随机字符串，当做记忆令牌；
2. 把这个令牌存入浏览器的 cookie 中，并把过期时间设为未来的某个日期；
3. 在数据库中存储令牌的摘要；
4. 在浏览器的 cookie 中存储加密后的用户 ID；
5. 如果 cookie 中有用户的 ID，就用这个 ID 在数据库中查找用户，并且检查 cookie 中的记忆令牌和数据库中的哈希摘要是否匹配。

`rails generate migration add_remember_digest_to_users remember_digest:string`



