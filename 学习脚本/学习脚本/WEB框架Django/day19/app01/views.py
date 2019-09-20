from django.shortcuts import render
from django.shortcuts import HttpResponse,redirect
from django.core.files.uploadedfile import InMemoryUploadedFile
# Create your views here.

import os

# USER_DICT = {
#     'k1': 'root1',
#     'k2': 'root2',
#     'k3': 'root3',
#     'k4': 'root4',
# }

USER_DICT = {
    '1': {'name':'root1', 'email': 'root@live.com'},
    '2': {'name':'root2', 'email': 'root@live.com'},
    '3': {'name':'root3', 'email': 'root@live.com'},
    '4': {'name':'root4', 'email': 'root@live.com'},
    '5': {'name':'root5', 'email': 'root@live.com'},
}

# USER_LIST = [
#   {'name': 'root1'},
#   {'name': 'root2'},
#   {'name':' root3'},
# ]
#
# {% for item in user_list %}


# '''
# def index(request,nid):
#     print(request.path_info)
#
#     from django.urls import reverse
#
#     v = reverse('indexx',args=(90))
#     print(v)
#
#     return render(request,'index.html', {'user_dict': USER_DICT})
#
#
# def detail(request,nid):
#      return HttpResponse(nid)
#      nid = request.GET.get('nid')
#      detail_info = USER_DICT[nid]
#      return render(request,'detail.html', {'detail_info':detail_info})
# '''


def index(request):
    return render(request,'index.html')


def user_info(request):
    if request.method == "GET":

        user_list = models.UserInfo.objects.all()

#        group_list =

        # print(user_list,query)
        # QuerySet [obj(id,username,email,user_group_id,user_group_username,user_group_email)]
        return render(request,'user_info.html',{'user_list':user_list})
    elif request.method == "POST":
        u = request.POST.get('user')
        p = request.POST.get('pwd')
        models.UserInfo.objects.create(username=u,password=p)
        return redirect('/cmdb/user_info/')
        # user_list = models.UserInfo.objects.all()
        # return render(request,'user_info.html',{'user_list':user_list})
    # print(user_list.query)


def user_detail(request, nid):
    obj = models.UserInfo.objects.filter(id=nid).first()
    # 取单挑数据，如果不存在，直接报错
    # models.UserInfo.objects.get(id=nid)
    return render(request,'user_detail.html',{'obj':obj})

def user_del(request, nid):
    models.UserInfo.objects.filter(id=nid).delete()
    return redirect('/cmdb/user_info/')

def user_edit(request, nid):
    if request.method == "GET":
        obj = models.UserInfo.objects.filter(id=nid).first()
        return render(request,'user_edit.html',{'obj':obj})
    elif request.method == "POST":
        nid = request.POST.get('id')
        u = request.POST.get('user')
        p = request.POST.get('password')
        models.UserInfo.objects.filter(id=nid).update(username=u,password=p)
        return redirect('/cmdb/user_info/')

def login(request):
    if request.method == "GET":
        return render(request,'login.html')
    elif request.method == "POST":
        u = request.POST.get('user')
        p = request.POST.get('pwd')
        obj = models.UserInfo.objects.filter(username=u,password=p).first()
        #count = models.UserInfo.objects.filter(username=u, password=p).count()
        #print(obj) # obj None,
        if obj:
            return redirect('/index/')
        else:
            return render(request,'login.html')
    else:
        # PUT,DELETE,HEAD,OPTION
        return redirect('/index/')


def login(request):
    if request.method == "GET":
        return render(request,'login.html')
    elif request.method == "POST":
        # 数据库中执行 select * from user where username='x' and password='x'
        return render(request,'login.html')
    else:
        return redirect('/index/')




from app01 import models
def orm(request):

    '''    
    创建
    models.UserInfo.objects.create(username = 'root', password = '123')    
    dic = {'username': 'eric', 'password': '666'}
    models.UserInfo.objects.create(**dic)
    obj = models.UserInfo(username = 'alex', password = '123')
    obj.save()
    
    查
    #result = models.UserInfo.objects.all()
    result = models.UserInfo.objects.filter(username='root')
    # result,QuerySet => Django => []
    # [obj(id,username,password),obj(id,username,password),obj(id,username,password)]
    for row in result:
        print(row.id,row.username,row.password)
    print(result)     

    删除
    models.UserInfo.objects.filter(id=3).delete()
    models.UserInfo.objects.filter(username='alex').delete()
    
    更新
    #models.UserInfo.objects.all().update(password=6669)
    models.UserInfo.objects.filter(id=1).update(password=69)
    
    一对多
    user_list = models.UserInfo.objects.all()
    
    '''

    # models.UserInfo.objects.create(
    #     username='root1',
    #     password='123',
    #     email='sdfdsfds',
    #     test='sadadas',
    #     user_group=models.UserGroup.objects.filter(id=1).first()
    # )

    models.UserInfo.objects.create(
        username='root1',
        password='123',
        email='sdfdsfds',
        test='sadadas',
        user_group=1
    )




    return HttpResponse('orm')

# def home(request):
#     return HttpResponse('home')

from django.views import View
class Home(View):

    def dispatch(self, request, *args, **kwargs):
        # 调用父类中的dispatch
        print('before')
        result = super(Home,self).dispatch(request,*args,**kwargs)
        print('after')
        return result

    def get(self,request):
        print(request.method)
        return render(request,'home.html')

    def post(self,request):
        print(request.method,'POST')
        return render(request, 'home.html')


