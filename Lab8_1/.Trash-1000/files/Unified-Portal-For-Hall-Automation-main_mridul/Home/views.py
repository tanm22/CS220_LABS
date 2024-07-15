from django.shortcuts import render

# Create your views here.

def Make_Homepage (request):
    # rendering the home page
    if request.user.is_authenticated:
        return render (request, 'Home.html')
    else:
        return render(request, "Error.html")
    
def map (request):
    # rendering the map page
    if request.user.is_authenticated:
        return render (request, 'Map.html')
    else:
        return render(request, "Error.html")
    
def contact (request):
    # rendering the contact page
    if request.user.is_authenticated:
        return render (request, 'Contact.html')
    else:
        return render(request, "Error.html")

def shop (request):
    # rendering the shop page
    if request.user.is_authenticated:
        return render (request, 'Shop.html')
    else:
        return render(request, "Error.html")