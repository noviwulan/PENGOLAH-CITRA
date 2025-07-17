function dino_game_with_image()
  close all;
  figure('Name','Game Dino Gambar','KeyPressFcn',@jump_key);

  global dino_y;
  global is_jumping;
  global jump_velocity;
  gravity = 0.002;

  dino_y = 0.2;
  is_jumping = false;
  jump_velocity = 0;

  % Load gambar dinosaurus
  dino_img = imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\dino.png');
  [img_h, img_w, ~] = size(dino_img);
  dino_img = im2double(dino_img);
  dino_img = flipud(dino_img); % BALIK gambar vertikal biar dino di atas

  % Posisi rintangan
  obstacle_x = 1;
  speed = 0.02;
  score = 0;
  game_over = false;

  while ~game_over
    clf;
    axis([0 1 0 1]);
    hold on;
    set(gca, 'xtick', [], 'ytick', []);
    ground_img = imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\tanah.png');
    ground_img = im2double(ground_img);
    ground_img = flipud(ground_img);  % BALIK gambar vertikal biar rumput di atas

    % Gambar tanah pakai image
    image('CData', ground_img, 'XData', [0 1], 'YData', [0 0.2]);

    % Gambar dinosaurus pakai image
    image('CData', dino_img, 'XData', [0.1 0.25], 'YData', [dino_y dino_y+0.15]);

   % Gambar rintangan
    obstacle_pos = [obstacle_x obstacle_x+0.05 obstacle_x+0.05 obstacle_x];
    fill(obstacle_pos, [0.2 0.2 0.3 0.3], 'r');

    % Update lompat
    if is_jumping
      dino_y += jump_velocity;
      jump_velocity -= gravity;
      if dino_y <= 0.2
        dino_y = 0.2;
        is_jumping = false;
        jump_velocity = 0;
      end
    end

    % Update rintangan
    obstacle_x -= speed;
    if obstacle_x < 0
      obstacle_x = 1 + rand();
      score += 1;
      speed = speed + 0.002 * score;  % Makin tinggi skor, makin cepat
    end

    % Deteksi tabrakan
    if obstacle_x < 0.25 && obstacle_x + 0.05 > 0.1 && dino_y < 0.35
      text(0.4, 0.5, 'GAME OVER', 'Color','r','FontSize',20);
      game_over = true;
    end

    % Tampilkan skor
    text(0.8, 0.95, ['Skor: ', num2str(score)], 'FontSize', 12);

    pause(0.03);
  endwhile
endfunction

function jump_key(~, event)
  global is_jumping;
  global jump_velocity;
  if strcmp(event.Key, 'space') && ~is_jumping
    is_jumping = true;
    jump_velocity = 0.03;
  end
endfunction

% Jalankan game
dino_game_with_image();
