import os

def extract_flutter_code(project_path, output_file):
    # Các thư mục muốn loại bỏ để tránh rác (build, .dart_tool, v.v.)
    exclude_dirs = {'.dart_tool', '.git', '.idea', 'build', 'windows', 'ios', 'android', 'linux', 'macos'}
    
    with open(output_file, 'w', encoding='utf-8') as f_out:
        f_out.write(f"--- PROJECT SOURCE CODE EXTRACT ---\n")
        f_out.write(f"Project Path: {project_path}\n\n")

        for root, dirs, files in os.walk(project_path):
            # Loại bỏ các thư mục không mong muốn
            dirs[:] = [d for d in dirs if d not in exclude_dirs]

            for file in files:
                # Chỉ lấy các file .dart
                if file.endswith('.dart'):
                    full_path = os.path.join(root, file)
                    # Lấy đường dẫn tương đối để dễ nhìn
                    relative_path = os.path.relpath(full_path, project_path)

                    f_out.write(f"{'='*50}\n")
                    f_out.write(f"FILE: {relative_path}\n")
                    f_out.write(f"{'='*50}\n\n")

                    try:
                        with open(full_path, 'r', encoding='utf-8') as f_in:
                            content = f_in.read()
                            f_out.write(content)
                            f_out.write("\n\n")
                    except Exception as e:
                        f_out.write(f"Error reading file: {e}\n\n")

    print(f"Hoàn thành! Đã lưu code vào file: {output_file}")

if __name__ == "__main__":
    # 1. Điền đường dẫn đến thư mục dự án Flutter của bạn vào đây
    path_to_flutter_project = r'C:/Users/HP/Desktop/Save/PTUDDDDNT/music_rss_app' 
    
    # 2. Tên file kết quả đầu ra
    output_filename = 'flutter_code_bundle.txt'

    # Kiểm tra đường dẫn tồn tại trước khi chạy
    if os.path.exists(path_to_flutter_project):
        extract_flutter_code(path_to_flutter_project, output_filename)
    else:
        print("Lỗi: Đường dẫn dự án không tồn tại. Vui lòng kiểm tra lại 'path_to_flutter_project'.")