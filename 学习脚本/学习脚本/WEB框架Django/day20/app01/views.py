from django.shortcuts import render,HttpResponse,redirect
from app01 import models
import json
# Create your views here.

def business(request):
    v1 = models.Business.objects.all()
    # QuerySet
    # [ obj(id,caption,code),obj(id,caption,code),obj(id,caption,code) ]

    v2 = models.Business.objects.all().values('id','caption')
    # QuerySet
    # [{'id':1,'caption':'运维部'},{'id':1,'caption':'运维部'},.....]

    v3 = models.Business.objects.all().values_list('id','caption')
    # Query
    # [(1,运维部)，(2,开发)]

    return render(request,'business.html',{'v1':v1,'v2':v2,'v3':v3})


# def host(request):
#     v1 = models.Host.objects.all()
#     # QuerySet [hostobj(ip,host),]
#
#     # for row in v1:
#     #     print(row.nid,row.hostname,row.ip,row.port,row.b_id,row.b.caption,row.b.code,row.b.id,sep='\t')
#
#     v2 = models.Host.objects.filter(nid__gt=0).values('nid','hostname','b_id','b__caption')
#     #return HttpResponse("Host")
#  #   print(v1)
#
#     for row in v2:
#         print(row['nid'],row['hostname'],row['b_id'],row['b__caption'])
#
#
#     v3 = models.Host.objects.filter(nid__gt=0).values_list('nid','hostname','b_id','b__caption')
#
#     return render(request, 'host.html', {'v1':v1,'v2':v2, 'v3':v3})

def host(request):
    if request.method == "GET":
        v1 = models.Host.objects.filter(nid__gt=0)
        v2 = models.Host.objects.filter(nid__gt=0).values('nid','hostname','b_id','b__caption')
        v3 = models.Host.objects.filter(nid__gt=0).values_list('nid','hostname','b_id','b__caption')

        b_list = models.Business.objects.all()
        return render(request, 'host.html', {'v1':v1,'v2':v2, 'v3':v3, 'b_list':b_list})

    elif request.method == "POST":
        h = request.POST.get('hostname')
        i = request.POST.get('ip')
        p = request.POST.get('port')
        b = request.POST.get('b_id')
        # models.Host.objects.create(hostname=h,
        #                            ip=i,
        #                            port=p,
        #                            b=models.Business.objects.get(id=b)
        #                            )

        models.Host.objects.create(hostname=h,
                                   ip=i,
                                   port=p,
                                   b_id=b
                                   )
        return redirect('/host')


def test_ajax(request):
    # print(request.method,request.GET.get('user'),request.GET.get('pwd'),sep='\t')
    # print(request.method, request.POST,sep='\t')
    # import time
    # time.sleep(5)


    ret = {'status':True, 'error':None, 'data':None}
    try:
        h = request.POST.get('hostname')
        i = request.POST.get('ip')
        p = request.POST.get('port')
        b = request.POST.get('b_id')

        if h and len(h) > 5:
            models.Host.objects.create(hostname=h,
                                       ip=i,
                                       port=p,
                                       b_id=b
                                       )

        else:
            ret['status'] = False
            ret['error'] = "太短了"
    except Exception as e:
        ret['status'] = False
        ret['error'] = "请求错误"
    return HttpResponse(json.dumps(ret))


def app(request):

    if request.method == "GET":
        app_list = models.Application.objects.all()
        host_list = models.Host.objects.all()
        return  render(request,'app.html',{"app_list":app_list,'host_list':host_list})

    elif request.method == "POST":
        app_name = request.POST.get('app_name')
        host_list = request.POST.getlist('host_list')
        print(app_name,host_list)

        obj = models.Application.objects.create(name=app_name)
        obj.r.add(*host_list)

        return redirect('/app')

    # for row in app_list:
    #     print(row.name,row.r.all())
    # return render(request,'app.html')
def ajax_add_app(request):
     ret = {'status':True, 'error':None, 'data':None}

     app_name = request.POST.get('app_name')
     host_list = request.POST.getlist('host_list')
     obj = models.Application.objects.create(name=app_name)
     obj.r.add(*host_list)
     return HttpResponse(json.dumps(ret))