/* 
 * 
 * Author : Parth Khandelwal
 */

//if(username.checkValidity() === false){
//        document.getElementById('signupDivMsg').innerText = username.validationMessage;
//    }

function searchProduct(){
    if(event.keyCode === 13){
//        alert('pressed Enter');
        var searchText = document.getElementById("searchField").value;
        if(searchText.trim().length!==0){
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.open("get","SearchProduct.jsp?searchText="+searchText, true);
            xmlhttp.send(null);
            xmlhttp.onreadystatechange = function() {
                if(xmlhttp.status === 404){
                    document.getElementById('mainSection').innerHTML = '<center><h2>404 Request Page Not Found</h2><center>';
                } else if(xmlhttp.status===500){
                    document.getElementById('mainSection').innerHTML = '<center><h2>Server Encountered An Error</h2><center>';
                } else if(xmlhttp.readyState === 4 && xmlhttp.status===200){
                    document.getElementById('mainSection').innerHTML = xmlhttp.responseText;
                } else {
                    document.getElementById('mainSection').innerHTML = '<center><h2>Loading Data</h2><center>';
                }
            };
        }
    }
}

function fetchCat(cat) {
//    var tabs = document.querySelectorAll('li');
//    for (var i = 0; i < tabs.length; i++) {
//        tabs[i].style.color = '#e6e4e0';
//        tabs[i].style.backgroundColor = '#6d0000';
//        tabs[i].style.fontWeight = 'normal';
//    }
//    var selected = document.getElementById(tab);
//    selected.style.color = 'black';
//    selected.style.background = 'white';
//    selected.style.fontWeight = 'bold';
    if(event.target === event.currentTarget){
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open('get', 'ShowProducts.jsp?cat=' + cat, true);
    xmlhttp.send(null);
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState === 0 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = '<center><h2>Connecting To Server</h2><center>';
        } else if (xmlhttp.readyState === 1 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = '<center><h2>Connection Established</h2><center>';
        } else if (xmlhttp.readyState === 2 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = '<center><h2>Retrieving Data</h2><center>';
        } else if (xmlhttp.readyState === 3 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = '<center><h2>Loading Data...</h2><center>';
        } else if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = xmlhttp.responseText;
        } else {
            document.getElementById('mainSection').innerHTML = '<center><h1>Loading...<h1><center>';
        }
    };
}
}

function fetch(cat, subcat) {
//    var tabs = document.querySelectorAll('li');
//    for (var i = 0; i < tabs.length; i++) {
//        tabs[i].style.color = '#e6e4e0';
//        tabs[i].style.backgroundColor = '#6d0000';
//        tabs[i].style.fontWeight = 'normal';
//    }
//    var selected = document.getElementById(tab);
//    selected.style.color = 'black';
//    selected.style.background = 'white';
//    selected.style.fontWeight = 'bold';

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open('get', 'ShowProducts.jsp?cat=' + cat + '&subcat=' + subcat, true);
    xmlhttp.send(null);
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState === 0 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = '<center><h2>Connecting To Server</h2><center>';
        } else if (xmlhttp.readyState === 1 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = '<center><h2>Connection Established</h2><center>';
        } else if (xmlhttp.readyState === 2 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = '<center><h2>Retrieving Data</h2><center>';
        } else if (xmlhttp.readyState === 3 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = '<center><h2>Loading Data...</h2><center>';
        } else if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            document.getElementById('mainSection').innerHTML = xmlhttp.responseText;
        } else {
            document.getElementById('mainSection').innerHTML = '<center><h2>Loading...<h2><center>';
        }
    };
}

function showLogin() {
    document.getElementById('loginRootDiv').style.display = 'block';
}

function closeLoginDiv(event) {
    if (event.target === event.currentTarget) {
            document.getElementById('loginRootDiv').style.display = 'none';
    }
}

function login() {
    var userid = document.getElementById('useridField').value;
    var pwd = document.getElementById('pwdField').value;
    if(userid.length===0 || pwd.length===0){
        document.getElementById('loginDivMsg').innerText = 'Provide Both UserID and Pwd';
    } else{
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open('POST', 'Login.jsp', true);
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlhttp.send('userid=' + userid + '&pwd=' + pwd);
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState === 0 && xmlhttp.status === 200) {
            document.getElementById('loginDivMsg').innerText = 'Loggin In';
        } else if (xmlhttp.readyState === 1 && xmlhttp.status === 200) {
            document.getElementById('loginDivMsg').innerText = 'Loggin In';
        } else if (xmlhttp.readyState === 2 && xmlhttp.status === 200) {
            document.getElementById('loginDivMsg').innerText = 'Loggin In';
        } else if (xmlhttp.readyState === 3 && xmlhttp.status === 200) {
            document.getElementById('loginDivMsg').innerText = 'Loggin In';
        } else if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            var msg = xmlhttp.responseText;
            msg=msg.trim();
            msg.toString();
            if (msg === 'yes') {
                document.location.href = "/uShop/";
            } else {
                document.getElementById('loginDivMsg').innerHTML = 'Userid & Password Mismatch';
            }
        } else {
            document.getElementById('loginDivMsg').innerHTML = '<center><h1>Loggin In<h1><center>';
        }
    };
    }
}

function logout() {
    document.location.href = 'Logout.jsp';
}

function showSignup(){
    document.getElementById('signupRootDiv').style.display = 'block';
}

function closeSignupDiv(event) {
    if (event.target === event.currentTarget) {
            document.getElementById('signupRootDiv').style.display = 'none';
    }
}
function signup() {
    document.getElementById('signupForm').validate;
    var username = document.getElementById('signupNameField');
    var userid = document.getElementById('signupUseridField').value;
    var pwd = document.getElementById('signupPwdField').value;
    var confPwd = document.getElementById('signupConfPwdField').value;
    var mob = document.getElementById('signupMobField').value;
//    alert(mob+ " " +userid);
    if (username.length === 0 || userid.length === 0 || pwd.length === 0 ) {
        document.getElementById('signupDivMsg').innerText = 'Fill All The Field';
    } else if (pwd !== confPwd) {
        document.getElementById('signupDivMsg').innerText = 'Passwords Mismatch';
    } else if (mob.length === 0 || mob.length!==10 || parseInt(mob)==NaN){
        document.getElementById('signupDivMsg').innerText = 'Invalid Mobile Number';
    } else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.open('POST', 'Signup.jsp', true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send('username=' +username+ '&userid=' + userid + '&pwd=' + pwd + '&mob=' + mob);
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState === 0 && xmlhttp.status === 200) {
                document.getElementById('signupDivMsg').innerText = 'Signing Up';
            } else if (xmlhttp.readyState === 1 && xmlhttp.status === 200) {
                document.getElementById('signupDivMsg').innerText = 'Signing Up';
            } else if (xmlhttp.readyState === 2 && xmlhttp.status === 200) {
                document.getElementById('signupDivMsg').innerText = 'Signing Up';
            } else if (xmlhttp.readyState === 3 && xmlhttp.status === 200) {
                document.getElementById('signupDivMsg').innerText = 'Signing Up';
            } else if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                var msg = xmlhttp.responseText;
                msg = msg.trim();
                msg.toString();
//                alert('__' + msg + '__');
                if (msg === 'yes') {
                    document.location.href = "/uShop/";
                } else if (msg === 'no'){
                    document.getElementById('loginDivMsg').innerHTML = 'Userid Not Available';
                } else {
                    document.getElementById('loginDivMsg').innerHTML = msg;
                }
            } else {
                document.getElementById('signupDivMsg').innerHTML = '<center><h1>Initiating Signup In<h1><center>';
            }
        };
    }
}

function showSubcategory(category) {
    document.getElementById(category).style.display = 'block';
}

function hideSubcategory(category) {
    document.getElementById(category).style.display = 'none';
}

function showProdDetails(id) {
    var table = document.getElementById(id);
    document.getElementById('prodDetailMsg').innerText = '';
    document.getElementById('prodId').value = id;
    document.getElementById('prodDetailImg').src = document.querySelector('img[name="' + id + '"]').src;
    document.getElementById('prodDetailName').innerText = table.rows[1].cells[0].innerText;
    document.getElementById('prodDetailPrice').innerText = table.rows[2].cells[0].innerText;
    document.getElementById('prodDetailQty').innerText = table.rows[3].cells[0].innerText;
    document.getElementById('prodDetailDesc').innerText = table.rows[4].cells[0].innerText;
    document.getElementById('prodDetailsRootDiv').style.display = 'block';
}
function closeProdDetails(event) {
    if (event.target === event.currentTarget) {
        document.getElementById('prodDetailsRootDiv').style.display = 'none';
    }
}

function showCart(){
    document.getElementById("cartRootDiv").style.display = 'block';
    document.getElementById("cartContentDiv").innerHTML = "<h3><center>Loading..<center></h3>";
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("get", "Cart.jsp", true);
    xmlhttp.send(null);
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            document.getElementById("cartContentDiv").innerHTML = xmlhttp.responseText;
        } else {
            document.getElementById("cartContentDiv").innerHTML = "<h3><center>Loading..<center></h3>";
        }
    };
}

function closeCartDiv(event){
    if(event.target === event.currentTarget){
        document.getElementById('cartRootDiv').style.display = 'none';
    }
}

function addItemToCart() {
    var id = document.getElementById('prodId').value;
    var prodDetailMsg = document.getElementById('prodDetailMsg');
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("get", "AddToCart.jsp?prod_id=" + id, true);
    xmlhttp.send(null);
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            prodDetailMsg.innerText = xmlhttp.responseText;
        } else {
            prodDetailMsg.innerText = 'Adding Item';
        }
    };
}

function removeItemsOfCart(){
    var checks = document.querySelectorAll("input[name='checks']");
//    var selectedChecks = new Array();
    var j=0;
    for(var i=0; i<checks.length; i++) {
        if(checks[i].checked === true) {
//            selectedChecks[j] = checks[i].value;
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.open("get", "RemoveFromCart.jsp?prod_id=" +checks[i].value, true);
            xmlhttp.send(null);
            xmlhttp.onreadystatechange = function(){
                if(xmlhttp.status === 500){
                    document.getElementById("cartMsg").innerText = "Server Encountered An Error";
                } else if(xmlhttp.status === 400){
                    document.getElementById("cartMsg").innerText = "404 Page Not Found";
                } else if(xmlhttp.status === 200 && xmlhttp.readyState===4){
                    document.getElementById("cartMsg").innerText = xmlhttp.responseText;
                    showCart();
                } else {
                    document.getElementById("cartMsg").innerText = "Processing";
                }
            };
            j++;
        }
    }
    if(j===0){
        document.getElementById("cartMsg").innerText = "Please Select Some Products";
    }
}

function showOrders(){
    document.getElementById("ordersRootDiv").style.display = 'block';
    document.getElementById("ordersContentDiv").innerHTML = "<h3><center>Loading..<center></h3>";
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("get", "Orders.jsp", true);
    xmlhttp.send(null);
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            document.getElementById("ordersContentDiv").innerHTML = xmlhttp.responseText;
        } else {
            document.getElementById("ordersContentDiv").innerHTML = "<h3><center>Loading..<center></h3>";
        }
    };
}

function closeOrdersDiv(event){
    if(event.target === event.currentTarget){
        document.getElementById('ordersRootDiv').style.display = 'none';
    }
}

function addItemToOrders() {
    var id = document.getElementById('prodId').value;
    var prodDetailMsg = document.getElementById('prodDetailMsg');
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("get", "AddToOrders.jsp?prod_id=" + id+ "&qty=1", true);
    xmlhttp.send(null);
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            prodDetailMsg.innerText = xmlhttp.responseText;
        } else {
            prodDetailMsg.innerText = 'Ordering Item';
        }
    };
}

function buyItemsOfCart() {
    var checks = document.querySelectorAll("input[name='checks']");
//    var selectedChecks = new Array();
    var j=0;
    for(var i=0; i<checks.length; i++) {
        if(checks[i].checked === true) {
//            selectedChecks[j] = checks[i].value;
            var qty = document.querySelector('input[name="'+checks[i].value+'"]').value;
//            alert(qty);
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.open("get", "AddToOrders.jsp?prod_id=" +checks[i].value+ "&qty=" +qty, true);
            xmlhttp.send(null);
            xmlhttp.onreadystatechange = function(){
                if(xmlhttp.status === 500){
                    document.getElementById("cartMsg").innerText = "Server Encountered An Error";
                } else if(xmlhttp.status === 400){
                    document.getElementById("cartMsg").innerText = "404 Page Not Found";
                } else if(xmlhttp.status === 200 && xmlhttp.readyState===4){
                    var response = xmlhttp.responseText.trim();
                    if(response === 'Thank You For Shopping'){
                        document.getElementById("cartMsg").innerText = response;
                        removeItemsOfCart();
                    } else {
                        document.getElementById("cartMsg").innerText = response;
                    }
                } else {
                    document.getElementById("cartMsg").innerText = "Removing from Cart";
                }
            };
            j++;
        }
    }
    if(j===0){
        document.getElementById("cartMsg").innerText = "Please Select Some Products To Buy";
    }
}