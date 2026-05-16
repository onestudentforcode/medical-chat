import tabula
import pandas as pd
import os

# PDF文件路径
pdf_path = r'c:\Users\88445\Desktop\dsl\6225604085de1.pdf'

# 检查文件是否存在
if not os.path.exists(pdf_path):
    print(f"错误: 文件 {pdf_path} 不存在")
    exit(1)

try:
    # 使用tabula提取PDF中的所有表格
    # pages="all" 表示提取所有页面的表格
    tables = tabula.read_pdf(pdf_path, pages="all", multiple_tables=True)
    
    if not tables:
        print("未在PDF中找到任何表格")
        exit(1)
    
    print(f"成功找到 {len(tables)} 个表格\n")
    
    # 创建输出目录
    output_dir = r'c:\Users\88445\Desktop\dsl\extracted_tables'
    os.makedirs(output_dir, exist_ok=True)
    
    # 保存每个表格为单独的CSV文件
    for i, table in enumerate(tables, 1):
        if table is not None and not table.empty:
            csv_filename = f'table_{i}.csv'
            csv_path = os.path.join(output_dir, csv_filename)
            
            # 保存为CSV文件
            table.to_csv(csv_path, index=False, encoding='utf-8-sig')
            
            print(f"表格 {i}:")
            print(f"  - 行数: {len(table)}")
            print(f"  - 列数: {len(table.columns)}")
            print(f"  - 列名: {list(table.columns)}")
            print(f"  - 保存至: {csv_path}")
            print()
        else:
            print(f"表格 {i}: 空表格，已跳过")
    
    print(f"\n所有表格已成功提取并保存到目录: {output_dir}")
    
except Exception as e:
    print(f"提取表格时发生错误: {str(e)}")
    import traceback
    traceback.print_exc()