import random
from django.shortcuts import render, redirect
from .models import User_class
from django.contrib.auth import authenticate, login, logout
from django.core.mail import send_mail
from django.conf import settings
from django.contrib import messages
from Home.views import Make_Homepage
import re

def Login(request):
    # for logging in the user
    if request.method== 'POST':                         # gets the username and password
        if 'submit_btn' in request.POST:
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)                    # login if correct credentials
                return redirect(Make_Homepage)
            else:
                messages.error(request, 'Incorrect Password or Username')                   #else error
                return render(request, "Login.html", context={'messages':messages.get_messages(request)})
    else:
        return render(request, "Login.html")
  
def Set_Password(request):
    # lets user set password for their account
    if '6' not in request.session:
        if '4' not in request.session:
            return redirect(Login)
        elif request.session['4'] == 1:
            return redirect(Reset_Password)
        else:
            return redirect(SignUp)
    if request.method=="POST":
        password1=request.POST.get("password1")
        password2=request.POST.get("password2")

        #checking password
        if password1 and password2 and password1!=password2:
            messages.error(request, "Passwords don't match")
            return render(request, "Set_Password.html", context={'messages':messages.get_messages(request)})
        pattern=re.compile("(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}")
        valid=re.fullmatch(pattern, password1)
        if not valid:
            messages.error(request, "Please Provide Stronger Password as per the condition")
            return render(request, "Set_Password.html", context={'messages':messages.get_messages(request)})
        if request.session['4']==0:                 # if new user, create account
            designation=request.session['2']
            if designation=="Student":
                name=request.session['0']
                username=request.session['1']
                if not name:
                    messages.error(request, 'Name was not found. Please try again')
                    return render(request, "Set_Password.html", context={'messages':messages.get_messages(request)})
                if not username:
                    messages.error(request, 'Username was not found. Please try again')
                    return render(request, "Set_Password.html", context={'messages':messages.get_messages(request)})
                user=User_class
                user=user.objects.create_user(
                    username=username,
                    name=name,
                    designation=designation,
                    password=password2,
                )
                request.session.flush()
            else:
                if User_class.objects.filter(designation=designation).exists():
                    messages.error(request, "Someone already exists with this designation")
                    return render(request, "Set_Password.html", context={'messages':messages.get_messages(request)})
                
                else:
                    name=request.session['0']
                    username=request.session['1']
                    if not name:
                        messages.error(request, 'Name was not found')
                        return render(request, "Set_Password.html", context={'messages':messages.get_messages(request)})

                    if not username:
                        messages.error(request, 'Username was not Found')
                        return render(request, "Set_Password.html", context={'messages':messages.get_messages(request)})
                    if designation=='Student':
                        user=User_class
                        user=user.objects.create_user(
                            name=name,
                            designation=designation,
                            username=username,
                            password=password2
                        )
                    elif designation=='Hall Manager':
                        user=User_class
                        user=user.objects.create_user(
                            name=name,
                            designation=designation,
                            username=username,
                            password=password2
                        )
                    elif designation=='Mess Manager':
                        user=User_class
                        user=user.objects.create_user(
                            name=name,
                            designation=designation,
                            username=username,
                            password=password2
                        )
                    elif designation=='Canteen Manager':
                        user=User_class
                        user=user.objects.create_user(
                            name=name,
                            designation=designation,
                            username=username,
                            password=password2
                        )
                    elif designation=='Sports Secy':
                        user=User_class
                        user=user.objects.create_user(
                            name=name,
                            designation=designation,
                            username=username,
                            password=password2
                        )
                    else:
                        messages.error(request, "No Such Designation")
                        return render(request, "Set_Password.html", context={'messages':messages.get_messages(request)})
                    request.session.flush()
            return redirect(Login)
        else:                                   # else change password
            username=request.session['5']
            request.session.flush()
            user=User_class.objects.filter(username=username)[0]
            user.set_password(password2)
            user.save()
            return redirect(Login)
    if request.method=="GET":
        if '4' in request.session:
            return render(request, "Set_Password.html")
        else:
            return redirect(Login)

def Reset_Password(request):
    # helps user change their password
    if request.method== 'POST':
        if request.session.test_cookie_worked():
            request.session.delete_test_cookie()
            username=request.POST.get("username")
            if username =='':
                messages.error(request, "Please put in the username")
                return render(request, "Reset_Password.html", context={'messages':messages.get_messages(request)})
            if not User_class.objects.filter(username=username).exists():
                messages.error(request, "No such username in base")
                return render(request, "Reset_Password.html", context={'messages':messages.get_messages(request)})
            request.session['5']=username
            request.session['4']=1
            return redirect(OTP_Send)
    request.session.set_test_cookie()
    return render(request, "Reset_Password.html")


def SignUp(request):
    # signup for taking user credentials
    if request.method=='POST':
        if request.session.test_cookie_worked():
            request.session.delete_test_cookie()
            name=request.POST.get("name")
            if name =='':
                messages.error(request, "Please put in the name")
                return render(request, "SignUp.html", context={'messages':messages.get_messages(request)})
            designation=request.POST.get("designation")
            if designation=='':
                messages.error(request, "Please put in the designation")
                return render(request, "SignUp.html", context={'messages':messages.get_messages(request)})
            username=request.POST.get("username")
            if username=='':
                messages.error(request, "Please put in the username")
                return render(request, "SignUp.html", context={'messages':messages.get_messages(request)})
            if "@" in username or "." in username or "iitk.ac.in" in username:
                messages.error(request, "Only username is needed not the whole email")
                return render(request, "SignUp.html", context={'messages':messages.get_messages(request)})
            if User_class.objects.filter(username = username):
                messages.error(request, "This Username has been already taken. Please check your username.")
                return render(request, "SignUp.html", context={'messages':messages.get_messages(request)})
            request.session.set_expiry(1000)
            request.session['0']=name
            request.session['1']=username
            request.session['2']=designation
            request.session['4']=0
            return redirect(OTP_Send)
        else:
            messages.error(request, "Please enable cookies and then try again")
            return render(request, "SignUp.html", context={'messages':messages.get_messages(request)})
    else:
        request.session.set_test_cookie()
        options1=1          # option 1 stores if a hall manager has already been made
        options2=1          # option 2 stores if a mess manager has already been made
        options3=1          # option 3 stores if a canteen manager has already been made
        options4=1          # option 4 stores if a sports secy has already been made
        if User_class.objects.filter(designation="Hall Manager").exists():
            options1=0
        if User_class.objects.filter(designation="Mess Manager").exists():
            options2=0
        if User_class.objects.filter(designation="Canteen Manager").exists():
            options3=0
        if User_class.objects.filter(designation="Sports Secy").exists():
            options4=0
        return render(request, "SignUp.html", context={"options1": options1, "options2":options2, "options3":options3, "options4":options4})

def OTP_Send(request):
    # sends an otp to the mail
    if request.method=="GET":
        if '6' not in request.session:
            otp = random.randrange(100000,999999)
            request.session['3']=otp
            if '4' in request.session:
                if request.session['4']==0:
                    name=request.session['0']
                    username=request.session['1']
                if request.session['4']==1:
                    username=request.session['5']
                    name=User_class.objects.filter(username=username)[0].name
                subject = f'OTP for SignUp - {otp}'
                message = f'Dear {name}, Your OTP for continuing on United Portal for Hall Automation is {otp}. Please be careful to not send it to third party.'
                email_from = settings.EMAIL_HOST_USER
                recipient_list = [f'{username}@iitk.ac.in',]
                send_mail(subject, message, email_from, recipient_list)
                return redirect(OTP)
            else:
                return redirect(Login)
        else:
            return redirect(Set_Password)

def OTP(request):
    # takes the otp and verifies it
    if request.method=="POST":
        otp1=request.POST.get("OTP")
        if otp1=='':
            messages.error(request, "Empty OTP field")
            return render(request, "OTP.html", context={'messages':messages.get_messages(request)})
        if '3' not in request.session:
            return redirect(SignUp)
        otp2=request.session['3']
        if otp1==str(otp2):
            request.session['6']=1
            return redirect(Set_Password)
        else:
            messages.error(request, 'incorrect OTP')                # if the otps dont match
            return render(request, "OTP.html", context={'messages':messages.get_messages(request)})
    if request.method=="GET":
        if '4' in request.session:
            return render(request, "OTP.html")
        else:
            return redirect(Login)
    
def Logout(request):
    # log out the user
    logout(request)
    return redirect(Login)