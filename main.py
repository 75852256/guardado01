import pygame
from util import load_save

pygame.init()
DISPLAY_W, DISPLAY_H = 480, 270
canvas = pygame.Surface((DISPLAY_W,DISPLAY_H))
window = pygame.display.set_mode(((DISPLAY_W * 2, DISPLAY_H * 2)))
running = True

actions = {"Left":False, "Right": False, "Up": False, "Down": False, "Start": False, "Action1": False}

save = load_save()

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_ESCAPE:
                running = False

    canvas.fill((135, 206, 235))
    window.blit(pygame.transform.scale(canvas, (DISPLAY_W * 2, DISPLAY_H * 2)), (0,0))
    pygame.display.update()