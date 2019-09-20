from django.shortcuts import render,HttpResponse,redirect

# Create your views here.

def login(request):

    # from django.conf import settings
    # print(settings.CSRF_HEADER_NAME)
    # # HTTP_X_CSRFTOKEN
    # X-CSRFtoken

    if request.method == "GET":
        return render(request,'login.html')
    elif request.method == "POST":
        user = request.POST.get('user')
        pwd = request.POST.get('pwd')
        if user == 'root' and pwd == "123":
            # 生成随机字符串
            # 写到用户浏览器cookie
            # 保存到session中
            # 在随机字符串对应的字典中设置相关内容.....

            request.session['username'] = user
            request.session['is_login'] = True

            if request.POST.get('rmb',None) == 1:
                # 人为设置超时时间
               request.session.set_expiry(10)
            return redirect('/index/')
        else:
            return render(request,'login.html')

def index(request):
    # 获取当前用户的随机字符串
    # 根据随机字符串获取对应信息
    # session中获取值

    if request.session.get('is_login',None):
        # return HttpResponse(request.session['username'])
        return render(request,'index.html',{'username':request.session['username']})
    else:
        return HttpResponse("滚")


def logout(request):
    # request.session['username']
    request.session.clear()
    return redirect('/login/')


def test(request):
    print("--> 没带钱")
    return HttpResponse("OK")


from django.views.decorators.cache import cache_page

@cache_page(3)

def cache(request):
    import time
    ctime = time.time()
    return render(request,'cache.html',{'ctime':ctime})


def signal(request):
    from app01 import models

    # obj = models.Tb1(user='root')
    obj = models.UserInf(user='root')
    print('end')
    obj.save()

    obj = models.UserInf(user='root')
    obj.save()

    obj = models.UserInf(user='root')
    obj.save()

    from sg import pizza_done

    pizza_done.send(sender="asdfdsfsd",topping=123,size=456)

    return HttpResponse("signal")

############################## Form ##############################

from django import forms

class FM(forms.Form):
    user = forms.CharField(error_messages={'required':'用户名不能为空'})
    pwd = forms.CharField(
        max_length=12,
        min_length=6,
    )
    email = forms.EmailField(error_messages={'required':'邮箱不能为空','invalid': "邮箱格式错误"})


def fm(request):

    if request.method == "GET":
        return render(request,'fm.html')
    elif request.method == "POST":
        # 获取用户所有数据
        # 每条数据请求的验证
        # 成功：获取所有的正确的信息
        # 失败：显示错误信息
        obj = FM(request.POST)
        r1 = obj.is_valid()
        if r1:
            print(obj.cleaned_data)
        else:
            print(obj.errors)

        return redirect('/fm/')