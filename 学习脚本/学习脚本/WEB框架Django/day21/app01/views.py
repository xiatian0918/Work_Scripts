from django.shortcuts import render,HttpResponse,redirect
from django.urls import reverse

# Create your views here.

# def index(request):
#     # v = reverse('author:index')
#     # print(v)
#
#     from django.core.handlers.wsgi import  WSGIRequest
#
#     print(type(request))
#     # 封装了所有用户请求信息
#     # print(request.environ)
#     # for k,v in request.environ.items():
#     #     print(k,v)
#
#     print(request.environ['HTTP_USER_AGENT'])
#     # request.POST
#     # request.GET
#     # request.COOKIES
#
#     return HttpResponse('OK')

def tpl1(request):

    user_list = [1,2,3,43]

    return render(request,'tpl1.html',{'u': user_list})

def tpl2(request):
    name = 'root'
    return render(request,'tpl2.html', {'name': name})

def tpl3(request):
    status = "已删除"
    return render(request,'tpl3.html', {'status':status})

def tpl4(request):
    name = "DSFSGsdfsf"
    return render(request,'tpl4.html',{'name':name})


# LIST = []
# for i in range(100):
#     LIST.append(i)
#
# def user_list(request):
#     current_page = request.GET.get('p',1)
#     current_page = int(current_page)
#
#     #current_page * 10
#     start = (current_page-1) * 10
#     end = current_page * 10
#     data = LIST[start:end]
#    # data = LIST[20:30]
#
#     all_count = len(LIST)
#     count,y = divmod(all_count,10)
#
#     page_list = []
#     for i in range(1,count+1):
#         temp = '<a href="/user_list/?p=%s">%s</a>' %(1,1)
#
#     page_str = """
#         <a href="/user_list/?p=1">1</a>
#         <a href="/user_list/?p=2">2</a>
#         <a href="/user_list/?p=3">3</a>
#     """
#     return render(request,'user_list.html', {'li': data})


from  utils import pagination
LIST = []
for i in range(500):
    LIST.append(i)

def user_list(request):
    current_page = request.GET.get('p', 1)
    current_page = int(current_page)

    # val = request.COOKIES.get('per_page_count')
    # val = int(val)
    # page_obj = pagination.Page(current_page,len(LIST),val)
    page_obj = pagination.Page(current_page, len(LIST))

    data = LIST[page_obj.start:page_obj.end]

    page_str = page_obj.page_str("/user_list/")

    return render(request, 'user_list.html', {'li': data,'page_str': page_str})


def auth(func):
    def inner(request,*args,**kwargs):
        v = request.COOKIES.get('username111')
        if not v:
            return redirect('/login/')
        return func(request,*args,**kwargs)
    return inner
@auth
def index(request):
    v =request.COOKIES.get('username111')
    # if not v:
    #     return redirect('/login/')
    return render(request,'index.html',{'current_user':v})

    from django import views

    # class Order(views.Views):




def order(request):
    v = request.COOKIES.get('username111')
    return render(request,'index.html',{'current_user':v})

##############################cookie###############################

user_info = {
    'dachengzi': {'pwd': '123123'},
    'kangbazi': {'pwd': 'kkkkkkkk'},
}

def login(request):

    if request.method == "GET":
        return render(request,'login.html')

    if request.method == "POST":
        u = request.POST.get('username')
        p = request.POST.get('pwd')
        dic = user_info.get(u)
        if not dic:
            return render(request,'login.html')
        if dic['pwd'] == p:
            res = redirect('/index/')
            # res.set_cookie('username111',u,max_age=10)
            # import datetime
            # current_date = datetime.datetime.utcnow()
            # current_date = current_date + datetime.timedelta(seconds=5)
            # res.set_cookie('username111', u, expires=current_date)
            res.set_cookie('username111', u,httponly=True)
            res.set_cookie('user_type','dsfdfgfdsadsa',httponly=True)
            return res
        else:
            return render(request,'login.html')

def index(request):
    # 获取当前已经登录的用户名
    v = request.COOKIES.get('username111')
    if not v:
        return redirect('/login/')
    return render(request,'index.html',{'current_user':v})


def cookie(request):
    #
    request.COOKIES
    request.COOKIES['username111']
    request.COOKIES.get('username111')

    response = render(request,'index.html')
    response = redirect('/index/')

    # 设置cookie,关闭浏览器失效
    response.set_cookie('key',"value")

    # 设置cookie，N秒之后失效
    response.set_cookie('username111', "value", max_age=10)

    # 设置cookie，截止时间失效
    import datetime
    current_date = datetime.datetime.utcnow()
    current_date = current_date + datetime.timedelta(seconds=5)
    response.set_cookie('username111', "value", expires=current_date)
    response.set_cookie('username111', "value", max_age=10)

    obj = HttpResponse('s')
    obj.set_signed_cookie('username','kangbazi',salt="sdfgs")
    request.get_signed_cookie('username',salt="gsfadsdfds")




    return response
