import time
import pymysql
import threading
from public.mysql import MySQL
from module.sync.finder.ip_mac_finder import IPMacFinder
from module.sync.finder.ip_usage_finder import IPUsageFinder
from multiprocessing.dummy import Pool as ThreadPool

def move_date():
    ip_need_to_move_list = []
    # sql = (
    #     "SELECT asset_ip_orginal.ip "
    #     "FROM asset_ip_orginal "
    #     "WHERE NOT EXISTS (SELECT asset_ip_usage_cache.ip FROM asset_ip_usage_cache WHERE asset_ip_orginal.ip = asset_ip_usage_cache.ip);"
    # )
    # sql = (
    #     "SELECT DISTINCT ip,arp,nmap,sec,mac,mac_organization,usage_id,usage_name,ident "
    #     "FROM asset_ip_orginal_old;"
    # )
    sql = (
        "SELECT DISTINCT ip,port,state,service,product,version,extrainfo,protocol,banner,url,login,status_code,server,x_powered_by,title,subtitle,footer,cms,response  "
        "FROM asset_detail_old "
        "where ip in (SELECT DISTINCT ip FROM asset_detail_old);"
    )
    data = MySQL(sql=sql).exec['data']
    if data:
        for item in data:
            ip_need_to_move_list.append(item)
            print("data item:",item)
    # print(ip_need_to_move_list)
    # sql_insert = (
    #     "insert into asset_ip_orginal(ip,arp,nmap,sec,mac,mac_organization,usage_id,usage_name,ident) "
    #     "values (%s, %s, %s, %s, %s, %s, %s, %s, %s) on duplicate key update ident=1;"
    # )
    sql_insert = (
        "insert into asset_detail(ip,port,state,service,product,version,extrainfo,protocol,banner,url,login,status_code,server,x_powered_by,title,subtitle,footer,cms,response) "
        "values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) on duplicate key update updateTime=now();"
    )

    print("正在插入新数据表...")
    insert = MySQL(sql=sql_insert).insertmany(ip_need_to_move_list)
    return insert

print("结果:\n",move_date())