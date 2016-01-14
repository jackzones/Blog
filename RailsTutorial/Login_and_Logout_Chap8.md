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
**测试步骤**
1. 访问登录页面；
2. 确认正确渲染了登录表单；
3. 提交无效的 params 哈希，向登录页面发起 post 请求；
4. 确认重新渲染了登录表单，而且显示了一个闪现消息；
5. 访问其他页面（例如首页）；
6. 确认这个页面中没显示前面那个闪现消息。

只测试单个文件的方法：
`bundle exec rake test TEST=test/integration/users_login_test.rb`

**变绿方法**
`flash.now[:danger] = 'Invalid email/password combination'`
`flash.now` 专门用于在重新渲染的页面中显示闪现消息.



